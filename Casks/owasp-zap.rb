cask 'owasp-zap' do
  version '2.6.0'
  sha256 'ed8f58c07bee746439879649a3b13bd7bffbccd6b1163c335f5eb0711ec3563d'

  # github.com/zaproxy/zaproxy was verified as official when first introduced to the cask
  url "https://github.com/zaproxy/zaproxy/releases/download/#{version}/ZAP_#{version.dots_to_underscores}_macos.dmg"
  appcast 'https://github.com/zaproxy/zaproxy/releases.atom',
          checkpoint: 'bb28e7a4fe165b05d9893df23bdd2b5c6c55a7cae86568b09773d74129204da8'
  name 'OWASP Zed Attack Proxy'
  name 'ZAP'
  homepage 'https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project'

  installer script: {
                      executable: 'OWASP Zed Attack Proxy Installer.app/Contents/MacOS/JavaApplicationStub',
                      args:       ['-q'],
                      sudo:       true,
                    }

  uninstall script: {
                      executable: "/Applications/ZAP #{version}.app/OWASP Zed Attack Proxy Uninstaller.app/Contents/MacOS/JavaApplicationStub",
                      args:       ['-q', '-c'],
                      sudo:       true,
                    },
            delete: "/Applications/ZAP #{version}.app"

  zap trash: [
               '~/Library/Preferences/org.zaproxy.zap.plist',
               '~/Library/Application Support/ZAP',
             ]

  caveats do
    depends_on_java('7+')
  end
end
