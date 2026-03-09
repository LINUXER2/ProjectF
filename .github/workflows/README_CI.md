# ProjectF CI/CD 配置说明

## 📋 功能

- ✅ 支持手动选择构建 Android 或 iOS
- ✅ 使用 Flutter 3.13.9 (原生版本)
- ✅ 编译完成后自动上传到蒲公英 (需配置 API Key)
- ✅ 构建产物保留 7 天供下载

## 🔧 配置步骤

### 1. 蒲公英 API Key (必需)

1. 登录 [蒲公英](https://www.pgyer.com)
2. 进入 **账号设置** → **API Key**
3. 复制 API Key
4. 在 GitHub 仓库的 **Settings** → **Secrets and variables** → **Actions** → **New repository secret**
5. 添加 secret:
   ```
   Name: PGYER_API_KEY
   Value: your_api_key_here
   ```

### 2. Apple 证书配置 (仅 iOS 需要)

如果构建 iOS，需要配置以下 secrets:

```
APPLE_SIGNING_KEY=your_p8_key_content
APPLE_CERTIFICATE_PASSWORD=your_cert_password
APPLE_ID=your_apple_id@example.com
APPLE_APP_SPECIFIC_PASSWORD=your_app_specific_password
APPLE_TEAM_ID=your_team_id
```

### 3. iOS ExportOptions

确保 `ios/ExportOptions.plist` 文件存在并配置正确：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>adhoc</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>manual</string>
    <key>signingCertificate</key>
    <string>Apple Distribution</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.yourcompany.projectf</key>
        <string>Your_Provisioning_Profile_Name</string>
    </dict>
</dict>
</plist>
```

## 🚀 使用方法

### 手动触发

1. 进入 GitHub 仓库的 **Actions** 标签
2. 选择 **Build & Upload to Pgyer** workflow
3. 点击 **Run workflow**
4. 选择参数:
   - **build_type**: `android` 或 `ios`
   - **env**: `test` 或 `prod`
   - **git_log**: 更新日志 (可选)
5. 点击 **Run workflow**

### 查看构建结果

- **构建日志**: Actions 页面查看实时日志
- **下载产物**: Workflow 完成后在底部 Artifacts 下载 APK/IPA
- **蒲公英链接**: 上传成功后会在日志中显示下载链接

## 📝 注意事项

1. **首次使用**: 建议先测试 Android 构建，确认配置正确
2. **API Key**: 蒲公英 API Key 需要妥善保管，不要提交到代码库
3. **iOS 证书**: iOS 构建需要正确的证书和 Provisioning Profile
4. **构建时间**: 首次构建可能需要 10-15 分钟 (下载依赖)

## 🔍 故障排查

### 构建失败

1. 检查 `pubspec.yaml` 依赖是否兼容 Flutter 3.13.9
2. 查看 Actions 日志中的具体错误信息
3. 本地运行 `flutter build apk` 或 `flutter build ipa` 验证

### 上传蒲公英失败

1. 确认 PGYER_API_KEY 已正确配置
2. 检查 API Key 是否有效 (登录蒲公英验证)
3. 文件大小是否超过限制 (免费用户 100MB)

### iOS 签名问题

1. 检查 ExportOptions.plist 配置
2. 确认证书和 Provisioning Profile 匹配
3. 检查 Apple ID 和应用专用密码是否正确

## 📞 支持

如有问题，请查看 GitHub Actions 日志或联系维护者。
