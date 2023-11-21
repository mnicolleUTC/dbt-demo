# Cloning the Repository 😊

This guide provides instructions on how to clone this repository : 
`https://github.com/mnicolleUTC/dbt-demo.git`  
It includes steps to verify if Git is installed on your system, how to install Git for Windows and macOS users, and then how to clone the repository.

## Verifying Git Installation 🧐

Before cloning the repository, ensure that Git is installed on your system.

1. Open Command Prompt (for Windows 🪟) or Terminal (for macOS 🍎).
2. Type `git --version` and press Enter.
3. If Git is installed, you will see the version number like this : `git version 2.42.0`.  
If not, follow the installation instructions below. 🔄

## Installing Git 🛠️

### On Windows 🪟
1. Download Git from [Git for Windows](https://git-scm.com/download/win).
2. Run the downloaded installer and follow the installation instructions. 👍
3. Once installed, restart your computer. 🔄
4. Verify your installation by typing `git --version` in Command Prompt. ✅

### On macOS 🍎
1. You can install Git using Homebrew. To verify if Homebrew is installed, you can type `brew --version`  
  If you don't have Homebrew, install it by running in Terminal the following command:  
  `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`  
  After installing Homebrew, add it to your PATH environment variable by running these commands:  
  `echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile`  
  `echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zprofile` (only if you use zsh)  
  Finally restart your terminal.
2. Install Git by running `brew install git` in the new Terminal. 🍺
3. After the installation completes, verify it by typing `git --version` in Terminal. ✅

## Cloning the Repository 🌟

Once Git is installed, you can clone the repository.

1. Open Terminal (macOS) or Command Prompt (Windows).
2. Navigate to the directory where you want to clone the repository.
3. Run the command : `git clone https://github.com/mnicolleUTC/dbt-demo.git`
4. Wait for the cloning process to complete. ⏳

Congratulations! 🎉 You have successfully cloned the repository.