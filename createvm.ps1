Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Создание формы ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "VM Creator"
$form.Size = New-Object System.Drawing.Size(500, 800)
$form.StartPosition = "CenterScreen"

# === Функция для проверки пути ===
function Test-ValidPath {
    param (
        [string]$path,
        [string]$errorMessage
    )
    if (-not (Test-Path $path)) {
        [System.Windows.Forms.MessageBox]::Show("$errorMessage`nПуть: $path", "Ошибка", "OK", "Error")
        return $false
    }
    return $true
}

# === Элементы формы ===
$labelVmName = New-Object System.Windows.Forms.Label
$labelVmName.Location = New-Object System.Drawing.Point(10, 20)
$labelVmName.Size = New-Object System.Drawing.Size(200, 20)
$labelVmName.Text = "Имя ВМ:"
$form.Controls.Add($labelVmName)

$textVmName = New-Object System.Windows.Forms.TextBox
$textVmName.Location = New-Object System.Drawing.Point(220, 20)
$textVmName.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($textVmName)

$labelIsoPath = New-Object System.Windows.Forms.Label
$labelIsoPath.Location = New-Object System.Drawing.Point(10, 50)
$labelIsoPath.Size = New-Object System.Drawing.Size(200, 20)
$labelIsoPath.Text = "Путь к ISO:"
$form.Controls.Add($labelIsoPath)

$textIsoPath = New-Object System.Windows.Forms.TextBox
$textIsoPath.Location = New-Object System.Drawing.Point(220, 50)
$textIsoPath.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($textIsoPath)

$buttonBrowseIso = New-Object System.Windows.Forms.Button
$buttonBrowseIso.Location = New-Object System.Drawing.Point(430, 50)
$buttonBrowseIso.Size = New-Object System.Drawing.Size(30, 20)
$buttonBrowseIso.Text = "..."
$buttonBrowseIso.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "ISO files (*.iso)|*.iso"
    if ($openFileDialog.ShowDialog() -eq "OK") {
        $textIsoPath.Text = $openFileDialog.FileName
    }
})
$form.Controls.Add($buttonBrowseIso)

$labelSwitchName = New-Object System.Windows.Forms.Label
$labelSwitchName.Location = New-Object System.Drawing.Point(10, 80)
$labelSwitchName.Size = New-Object System.Drawing.Size(200, 20)
$labelSwitchName.Text = "Имя виртуального коммутатора:"
$form.Controls.Add($labelSwitchName)

$textSwitchName = New-Object System.Windows.Forms.TextBox
$textSwitchName.Location = New-Object System.Drawing.Point(220, 80)
$textSwitchName.Size = New-Object System.Drawing.Size(250, 20)
$textSwitchName.Text = "NatNetworkSwitch"
$form.Controls.Add($textSwitchName)

$labelVmMemory = New-Object System.Windows.Forms.Label
$labelVmMemory.Location = New-Object System.Drawing.Point(10, 110)
$labelVmMemory.Size = New-Object System.Drawing.Size(200, 20)
$labelVmMemory.Text = "Объем памяти (ГБ):"
$form.Controls.Add($labelVmMemory)

$textVmMemory = New-Object System.Windows.Forms.TextBox
$textVmMemory.Location = New-Object System.Drawing.Point(220, 110)
$textVmMemory.Size = New-Object System.Drawing.Size(250, 20)
$textVmMemory.Text = "8"
$form.Controls.Add($textVmMemory)

$labelVhdSize = New-Object System.Windows.Forms.Label
$labelVhdSize.Location = New-Object System.Drawing.Point(10, 140)
$labelVhdSize.Size = New-Object System.Drawing.Size(200, 20)
$labelVhdSize.Text = "Размер диска (ГБ):"
$form.Controls.Add($labelVhdSize)

$textVhdSize = New-Object System.Windows.Forms.TextBox
$textVhdSize.Location = New-Object System.Drawing.Point(220, 140)
$textVhdSize.Size = New-Object System.Drawing.Size(250, 20)
$textVhdSize.Text = "50"
$form.Controls.Add($textVhdSize)

$labelIp = New-Object System.Windows.Forms.Label
$labelIp.Location = New-Object System.Drawing.Point(10, 170)
$labelIp.Size = New-Object System.Drawing.Size(200, 20)
$labelIp.Text = "IP-адрес:"
$form.Controls.Add($labelIp)

$textIp = New-Object System.Windows.Forms.TextBox
$textIp.Location = New-Object System.Drawing.Point(220, 170)
$textIp.Size = New-Object System.Drawing.Size(250, 20)
$textIp.Text = "10.0.1.200"
$form.Controls.Add($textIp)

$labelHostname = New-Object System.Windows.Forms.Label
$labelHostname.Location = New-Object System.Drawing.Point(10, 200)
$labelHostname.Size = New-Object System.Drawing.Size(200, 20)
$labelHostname.Text = "Имя хоста:"
$form.Controls.Add($labelHostname)

$textHostname = New-Object System.Windows.Forms.TextBox
$textHostname.Location = New-Object System.Drawing.Point(220, 200)
$textHostname.Size = New-Object System.Drawing.Size(250, 20)
$textHostname.Text = "\$vmName.local"
$form.Controls.Add($textHostname)

$labelGateway = New-Object System.Windows.Forms.Label
$labelGateway.Location = New-Object System.Drawing.Point(10, 230)
$labelGateway.Size = New-Object System.Drawing.Size(200, 20)
$labelGateway.Text = "Шлюз:"
$form.Controls.Add($labelGateway)

$textGateway = New-Object System.Windows.Forms.TextBox
$textGateway.Location = New-Object System.Drawing.Point(220, 230)
$textGateway.Size = New-Object System.Drawing.Size(250, 20)
$textGateway.Text = "10.0.1.1"
$form.Controls.Add($textGateway)

$labelNetmask = New-Object System.Windows.Forms.Label
$labelNetmask.Location = New-Object System.Drawing.Point(10, 260)
$labelNetmask.Size = New-Object System.Drawing.Size(200, 20)
$labelNetmask.Text = "Маска подсети:"
$form.Controls.Add($labelNetmask)

$textNetmask = New-Object System.Windows.Forms.TextBox
$textNetmask.Location = New-Object System.Drawing.Point(220, 260)
$textNetmask.Size = New-Object System.Drawing.Size(250, 20)
$textNetmask.Text = "255.255.255.0"
$form.Controls.Add($textNetmask)

$labelDns = New-Object System.Windows.Forms.Label
$labelDns.Location = New-Object System.Drawing.Point(10, 290)
$labelDns.Size = New-Object System.Drawing.Size(200, 20)
$labelDns.Text = "DNS-серверы (через запятую):"
$form.Controls.Add($labelDns)

$textDns = New-Object System.Windows.Forms.TextBox
$textDns.Location = New-Object System.Drawing.Point(220, 290)
$textDns.Size = New-Object System.Drawing.Size(250, 20)
$textDns.Text = "8.8.8.8,1.1.1.1"
$form.Controls.Add($textDns)

$labelRootPassword = New-Object System.Windows.Forms.Label
$labelRootPassword.Location = New-Object System.Drawing.Point(10, 320)
$labelRootPassword.Size = New-Object System.Drawing.Size(200, 20)
$labelRootPassword.Text = "Root пароль:"
$form.Controls.Add($labelRootPassword)

$textRootPassword = New-Object System.Windows.Forms.TextBox
$textRootPassword.Location = New-Object System.Drawing.Point(220, 320)
$textRootPassword.Size = New-Object System.Drawing.Size(250, 20)
$textRootPassword.Text = "MySecurePassword123"
$form.Controls.Add($textRootPassword)

$labelPrivateKey = New-Object System.Windows.Forms.Label
$labelPrivateKey.Location = New-Object System.Drawing.Point(10, 350)
$labelPrivateKey.Size = New-Object System.Drawing.Size(200, 20)
$labelPrivateKey.Text = "Приватный ключ SSH:"
$form.Controls.Add($labelPrivateKey)

$textPrivateKey = New-Object System.Windows.Forms.TextBox
$textPrivateKey.Location = New-Object System.Drawing.Point(220, 350)
$textPrivateKey.Size = New-Object System.Drawing.Size(250, 20)
$textPrivateKey.Multiline = $true
$textPrivateKey.Height = 60
$form.Controls.Add($textPrivateKey)

$labelPublicKey = New-Object System.Windows.Forms.Label
$labelPublicKey.Location = New-Object System.Drawing.Point(10, 420)
$labelPublicKey.Size = New-Object System.Drawing.Size(200, 20)
$labelPublicKey.Text = "Публичный ключ SSH:"
$form.Controls.Add($labelPublicKey)

$textPublicKey = New-Object System.Windows.Forms.TextBox
$textPublicKey.Location = New-Object System.Drawing.Point(220, 420)
$textPublicKey.Size = New-Object System.Drawing.Size(250, 20)
$textPublicKey.Multiline = $true
$textPublicKey.Height = 60
$form.Controls.Add($textPublicKey)

$buttonCreate = New-Object System.Windows.Forms.Button
$buttonCreate.Location = New-Object System.Drawing.Point(200, 500)
$buttonCreate.Size = New-Object System.Drawing.Size(100, 30)
$buttonCreate.Text = "Создать ВМ"
$buttonCreate.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $buttonCreate
$form.Controls.Add($buttonCreate)

# === Показ формы ===
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    # === Получение значений из формы ===
    $vmName = $textVmName.Text.Trim()
    $isoPath = $textIsoPath.Text.Trim()
    $switchName = $textSwitchName.Text.Trim()
    $vmMemory = [long]($textVmMemory.Text.Trim()) * 1GB
    $vhdSize = [long]($textVhdSize.Text.Trim()) * 1GB
    $ip = $textIp.Text.Trim()
    $hostname = $textHostname.Text.Trim() -replace "\$vmName", $vmName
    $gateway = $textGateway.Text.Trim()
    $netmask = $textNetmask.Text.Trim()
    $dns = $textDns.Text.Trim()
    $rootPassword = $textRootPassword.Text.Trim()
    $privateKey = $textPrivateKey.Text.Trim()
    $publicKey = $textPublicKey.Text.Trim()

    # === Проверка обязательных полей ===
    if ([string]::IsNullOrWhiteSpace($vmName)) {
        [System.Windows.Forms.MessageBox]::Show("Имя ВМ не может быть пустым.", "Ошибка", "OK", "Error")
        exit
    }

    if ([string]::IsNullOrWhiteSpace($isoPath) -or -not (Test-ValidPath $isoPath "Указан неверный путь к ISO файлу.")) {
        exit
    }

    if ([string]::IsNullOrWhiteSpace($rootPassword)) {
        [System.Windows.Forms.MessageBox]::Show("Root пароль не может быть пустым.", "Ошибка", "OK", "Error")
        exit
    }

    if ([string]::IsNullOrWhiteSpace($privateKey) -or [string]::IsNullOrWhiteSpace($publicKey)) {
        [System.Windows.Forms.MessageBox]::Show("SSH ключи не могут быть пустыми.", "Ошибка", "OK", "Error")
        exit
    }

    # === Основные пути ===
    $vmBasePath = "F:\$vmName"
    $vhdPath = "$vmBasePath\$vmName.vhdx"
    $ksSourceFolder = "$vmBasePath\KS_ISO"
    $ksIsoPath = "$ksSourceFolder\ks.iso"
    $answerFilePath = "$ksSourceFolder\ks.cfg"

    # === Создание базовой директории для ВМ ===
    if (-not (Test-Path $vmBasePath)) {
        New-Item -ItemType Directory -Path $vmBasePath -Force
        Write-Host "[+] Создана базовая директория для ВМ: '$vmBasePath'"
    }

    # === Рассчитываем размеры разделов (в МБ) ===
    $vhdSizeMB = [Math]::Floor($vhdSize / 1MB)

    $bootEFISize = 600
    $bootSize = 1024
    $swapSize = 4078
    $rootMinSize = 1024

    $pvSize = $vhdSizeMB - $bootEFISize - $bootSize - 100
    $rootMaxSize = $pvSize - $swapSize

    if ($rootMaxSize -lt $rootMinSize) {
        Write-Error "VHD слишком мал: нужен минимум $([Math]::Ceiling((600+1024+4078+1024)/1024)) ГБ"
        exit
    }

    # === Создать папку для ks.cfg ===
    Remove-Item -Path $ksSourceFolder -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Path $ksSourceFolder -Force
    Write-Host "[+] Создана директория для Kickstart: '$ksSourceFolder'"

    # === Генерация ks.cfg ===
    $ksContent = @"
#version=RHEL9
text
repo --name="minimal" --baseurl=file:///run/install/sources/mount-0000-cdrom/minimal
%addon com_redhat_kdump --disable
%end
keyboard --vckeymap=ru --xlayouts='us','ru' --switch='grp:alt_shift_toggle'
lang ru_RU.UTF-8
network --bootproto=static --device=eth0 --ip=$ip --netmask=$netmask --gateway=$gateway --nameserver=$dns --ipv6=auto --activate
network --hostname=$hostname
cdrom
selinux --disabled
firewall --disabled
%packages
@^minimal-environment
%end
firstboot --enable
ignoredisk --only-use=sda
clearpart --none --initlabel
part pv.50 --fstype="lvmpv" --ondisk=sda --size=$pvSize
part /boot/efi --fstype="efi" --ondisk=sda --size=$bootEFISize --fsoptions="umask=0077,shortname=winnt"
part /boot --fstype="ext4" --ondisk=sda --size=$bootSize
volgroup rl --pesize=4096 pv.50
logvol / --fstype="ext4" --grow --maxsize=$rootMaxSize --size=$rootMinSize --name=root --vgname=rl
logvol swap --fstype="swap" --size=$swapSize --name=swap --vgname=rl
timezone Asia/Krasnoyarsk --utc
rootpw --plaintext --allow-ssh $rootPassword
reboot
timesource --ntp-disable

%post
echo "Запускаю dnf update..."
dnf -y update
dnf -y install mc vim net-tools wget curl bash-completion
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl disable firewalld --now

# Настройка SSH-ключа
mkdir -p /root/.ssh
chmod 700 /root/.ssh
echo "$privateKey" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "$publicKey" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

echo "Post-install: dnf update completed at $(date)" > /root/post-complete.log
%end
"@

    Set-Content -Path $answerFilePath -Value $ksContent -Encoding Ascii
    Write-Host "[+] ks.cfg сгенерирован для '${vmName}': '${answerFilePath}'"

    # === Путь к oscdimg и efisys_noprompt.bin ===
    $oscdimgPath = "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"
    $oscdimgExe = "$oscdimgPath\oscdimg.exe"
    $efiBootFile = "$oscdimgPath\efisys_noprompt.bin"

    # === Проверка наличия oscdimg ===
    if (-not (Test-Path $oscdimgExe)) {
        Write-Error "oscdimg.exe не найден: $oscdimgExe"
        Write-Host "Убедитесь, что установлен Windows ADK с компонентом Deployment Tools."
        exit
    }

    if (-not (Test-Path $efiBootFile)) {
        Write-Error "Файл загрузчика не найден: $efiBootFile"
        exit
    }

    # === Создать ks.iso ===
    if (Test-Path $ksIsoPath) { Remove-Item $ksIsoPath -Force }
    Write-Host "[+] Создаю загрузочный ks.iso..."

    & $oscdimgExe -b"$efiBootFile" -h -o -m -u2 -lksiso "$ksSourceFolder" "$ksIsoPath"

    if (-not (Test-Path $ksIsoPath)) {
        Write-Error "Не удалось создать ks.iso"
        exit
    }

    Write-Host "[+] ks.iso успешно создан: '${ksIsoPath}'"

    # === Создать виртуальную машину ===
    Write-Host "[*] Создаю виртуальную машину '${vmName}'..."
    try {
        New-VM -Name $vmName -MemoryStartupBytes $vmMemory -SwitchName $switchName -Generation 2 -NoVHD -ErrorAction Stop
        Set-VM -VMName $vmName -ProcessorCount 2
        Set-VMFirmware -VMName $vmName -EnableSecureBoot Off
    } catch {
        Write-Error "Ошибка при создании ВМ: $_"
        exit
    }

    # === Создать и подключить диск ===
    try {
        New-VHD -Path $vhdPath -SizeBytes $vhdSize -Dynamic -ErrorAction Stop
        Add-VMHardDiskDrive -VMName $vmName -Path $vhdPath -ErrorAction Stop
    } catch {
        Write-Error "Ошибка при создании или подключении диска: $_"
        exit
    }

    # === Подключить ISO-диски ===
    try {
        Add-VMDvdDrive -VMName $vmName -Path $isoPath -ErrorAction Stop
        Add-VMDvdDrive -VMName $vmName -Path $ksIsoPath -ErrorAction Stop
    } catch {
        Write-Error "Ошибка при подключении DVD: $_"
        exit
    }

    # === Настроить загрузку с основного ISO ===
    $dvdDrive = Get-VMDvdDrive -VMName $vmName | Where-Object Path -eq $isoPath
    if ($dvdDrive) {
        Set-VMFirmware -VMName $vmName -FirstBootDevice $dvdDrive
    } else {
        Write-Warning "Не удалось определить основной DVD-привод для загрузки."
    }

    # === Запустить и открыть консоль ===
    try {
        Start-VM -Name $vmName -ErrorAction Stop
        Start-Sleep -Seconds 3
        Start-Process vmconnect -ArgumentList "localhost $vmName"
        Write-Host "[*] ВМ '$vmName' запущена. Открыта консоль управления."
    } catch {
        Write-Error "Ошибка при запуске ВМ: $_"
    }
}
