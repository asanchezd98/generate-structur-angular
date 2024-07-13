try {
	# Check if Node.js is installed
	if (-Not (Get-Command node -ErrorAction SilentlyContinue)) {
		$installNode = Read-Host -Prompt "Node.js is not installed. Do you want to install it using Node.js? (y/n)"
		
		if ($PSVersionTable.PSEdition -eq 'Core') {
			Write-Host "The operating system is Linux."
			# Check if Chocolatey is installed
			if ($installNode -eq "y") {
				#update and install Node.js using apt
				sudo apt update
				sudo apt install curl
				curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
				sudo apt-get install -y nodejs

				node --version
				npm --version


				# Verify the installation
				if (Get-Command node -ErrorAction SilentlyContinue) {
					Write-Host "Node.js has been installed successfully."
				} else {
					Write-Host "Node.js installation failed."
					exit
				}
			} else {
				Write-Host "Node.js is required for this script. Please install it from https://nodejs.org/ and try again.."
				exit
			}
		}
		#Install Node.js in Windows
		elseif ($PSVersionTable.PSEdition -eq 'Desktop') {
			Write-Host "The operating system is Windows."
			if ($installNode -eq "y") {

				# Check if Chocolatey is installed
				if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
					Write-Host "Installing Chocolatey..."
					Set-ExecutionPolicy Bypass -Scope Process -Force
					[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; 
					iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
				}
				
				Write-Host "Installing Node.js using Chocolatey..."
				# Install Node.js using Chocolatey
				choco install nodejs-lts
				
				node --version
				npm --version

				# Verify the installation
				if (Get-Command node -ErrorAction SilentlyContinue) {
					Write-Host "Node.js has been installed successfully."
				} else {
					Write-Host "Node.js installation failed."
					exit
				}
			} else {
				Write-Host "Node.js is required for this script. Please install it from https://nodejs.org/ and try again.."
				exit
			}
		} else {
			Write-Host "The operating system is not Windows or Linux."
			exit
		}
	} else {
		Write-Host "Node.js is already installed."
	}

	# Check if Angular CLI is installed
	if (-Not (Get-Command ng -ErrorAction SilentlyContinue)) {
		$installAngularCLI = Read-Host -Prompt "Angular CLI is not installed. Do you want to install it? (y/n)"
		if ($installAngularCLI -eq "y") {
			Write-Host "Installing Angular CLI globally..."
			
			if ($PSVersionTable.PSEdition -eq 'Core') {
				sudo npm install -g @angular/cli
			} elseif ($PSVersionTable.PSEdition -eq 'Desktop') {
				npm install -g @angular/cli
			} else {
				Write-Host "Unknown PowerShell edition."
			}

			# Verify the installation
			if (Get-Command ng -ErrorAction SilentlyContinue) {
				Write-Host "Angular CLI has been installed successfully."
			} else {
				Write-Host "Angular CLI installation failed."
				exit
			}
		} else {
			Write-Host "Angular CLI is required for this script. Exiting."
			exit
		}
	} else {
		Write-Host "Angular CLI is already installed."
	}

	# Ask for the Angular project name
	$projectName = Read-Host -Prompt "Enter the name of the Angular project"

	# Create a new Angular application
	ng new $projectName

	Write-Host "The Angular template has been created successfully in the '$projectName' folder."

	# Entry to the protection location 
	cd $projectName

	# Install Materials
	$installMaterial = Read-Host -Prompt "Do you want to install Materials? (y/n)"
	if ($installMaterial -eq "y") {
		Write-Host "Installing Material..."
		ng add @angular/material@^17
	}

	# Creating the architecture
	# Creating component app
	New-Item -ItemType File -Path .\src\app\ -Name "app-routing.module.ts"
	New-Item -ItemType File -Path .\src\app\ -Name "app.module.ts"

	# Creating Core
	New-Item -ItemType Directory -Path .\src\app\core\nameModule\nameModule-module
	New-Item -ItemType Directory -Path .\src\app\core\nameModule\modals\modal-action-nameModule
	New-Item -ItemType Directory -Path .\src\app\core\nameModule\services
	New-Item -ItemType File -Path .\src\app\core\nameModule\ -Name "nameModule.module.ts"

	# Creating master-page
	New-Item -ItemType Directory -Path .\src\app\master-page\dashboard
	New-Item -ItemType Directory -Path .\src\app\master-page\footer
	New-Item -ItemType Directory -Path .\src\app\master-page\home
	New-Item -ItemType Directory -Path .\src\app\master-page\navbar
	New-Item -ItemType Directory -Path .\src\app\master-page\services
	New-Item -ItemType Directory -Path .\src\app\master-page\sidebar
	New-Item -ItemType File -Path .\src\app\master-page\ -Name "master-page.module.ts"

	# Creating shared
	New-Item -ItemType Directory -Path .\src\app\shared\components\modals\modal-confirm
	New-Item -ItemType Directory -Path .\src\app\shared\components\modals\modal-message
	New-Item -ItemType Directory -Path .\src\app\shared\components\toasts\toast-message
	New-Item -ItemType Directory -Path .\src\app\shared\enums
	New-Item -ItemType Directory -Path .\src\app\shared\interceptors
	New-Item -ItemType Directory -Path .\src\app\shared\interfaces
	New-Item -ItemType Directory -Path .\src\app\shared\services
	New-Item -ItemType File -Path .\src\app\shared\ -Name "shared.module.ts"

	# Creating assets
	New-Item -ItemType Directory -Path .\src\assets\icons
	New-Item -ItemType Directory -Path .\src\assets\images
	New-Item -ItemType Directory -Path .\src\assets\scss\components

	# Creating environments
	New-Item -ItemType Directory -Path .\src\environments
	New-Item -ItemType File -Path .\src\environments -Name "environment.dev.ts"
	New-Item -ItemType File -Path .\src\environments -Name "environment.prod.ts"
	New-Item -ItemType File -Path .\src\environments -Name "environment.qa.ts"
	New-Item -ItemType File -Path .\src\environments -Name "environment.ts"

	# Open project Angular with VS Code
	if ($PSVersionTable.PSEdition -eq 'Core') {
		# For PowerShell Core (Linux)
		if ((Test-Path "/usr/share/code/bin/code")) {
			Write-Host "Visual Studio Code is installed."
			sudo code .
		}
		else {
			$installVSCode = Read-Host -Prompt "Visual Studio Code is not installed. Do you want to install Visual Studio Code? (y/n)"
			if ($installVSCode -eq "y") {
				Write-Host "Installing Visual Studio Code..."
				sudo snap install --classic code
				code .
			}
		}
	} elseif ($PSVersionTable.PSEdition -eq 'Desktop') {
		# For Windows PowerShell
		$vsCodePath = Get-Command code -ErrorAction SilentlyContinue

		if ($vsCodePath) {
			Write-Host "Visual Studio Code is installed."
			code .
		} else {
			Write-Host "Visual Studio Code is not installed."
			Write-Host "Installing Visual Studio Code using Chocolatey..."
			choco install vscode -y
			code .
		}
	} else {
		Write-Host "Unknown PowerShell edition."
	}
}
catch {
    # Bloque que se ejecuta si ocurre una excepción
    Write-Host "Ha ocurrido una excepción: $_.Exception.Message"
    # Puedes realizar acciones de recuperación o registro de errores aquí
}
finally {
    # Este bloque se ejecutará siempre, ocurra una excepción o no
    Write-Host "Finalizando proceso."
}