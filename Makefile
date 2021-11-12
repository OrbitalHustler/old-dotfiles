LOGFILE=/tmp/dotfiles.log
CHEZMOI=~/.local/bin/chezmoi

default: run
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
	@echo '    make first              Do this first!'
	@echo '    make run                Ensure deps and apply chezmoi.'
	@echo '    make all                Run all.'

	@echo '    make update             Update configs: zsh, tmux, asdf'
	@echo '    make update-zsh-completions'
	@echo
	@echo '    make start-services     Starts services (systemd...).'
	@echo '    make install-env        Install environment.'
	@echo '    make conf-sys           Configure system files.'
	@echo '    make ssh-perms          Set SSH permissions.'
	@echo '    make gnupg-perms        Set GnuPG permissions.'
	@echo '    make configure-sys      Configure system'
	@echo '    make ensure-deps        Install all dependencies.'
	@echo '    make chezmoi-init       Initialize chezmoi.'
	@echo '    make chezmoi-apply      Apply chezmoi files (runs all scripts).'
	@echo '    make post-chezmoi       Run post chezmoi scripts.'
	@echo '    make install-chezmoi    Install chezmoi.'
	@echo '    make install-deps       Install system dependencies.'
	@echo '    make install-fonts      Install fonts.'
	@echo '    make ensure-dirs        Creates required directories.'
	@echo
	@echo
	@echo '    Logs are stored in      $(LOGFILE)'

update-tmux:
	~/.local/tmux/plugins/tpm/bin/install_plugins
	~/.local/tmux/plugins/tpm/bin/update_plugins all

# TODO Find a better way than asking user to update theirself!
update-zinit:
	echo ">>>> PLEASE Run the following command:\nzinit self-update && zinit update --all"

install-asdf:
	./scripts/asdf/install_asdf.sh

update-asdf:
	./scripts/asdf/update_asdf_plugins.sh

update-python:
	pip3 install --upgrade pip
	pip3 install --upgrade pynvim pytest flake8 black isort nose
update-vim:
	pip3 install pynvim flake8 --upgrade
	vim +'PlugInstall' +qa
	vim +'UpdateRemotePlugins' +qa

update:
	$(MAKE) update-tmux
	$(MAKE) update-asdf
	$(MAKE) update-vim
	$(MAKE) update-zinit

update-zsh-completions:
	echo "Not yet implemented"

start-services:
	@echo "Starting services.."
	bash ./scripts/start_services.sh | tee -a $(LOGFILE)

install-env:
	@echo "Installing env..."
	bash ./scripts/install_env.sh | tee -a $(LOGFILE)

conf-sys:
	@echo "Configuring system.."
	bash ./scripts/configure_sys.sh | tee -a $(LOGFILE)

ssh-perms:
	@echo "Setting SSH permissions.."
	bash ./scripts/set_ssh_perms.sh | tee -a $(LOGFILE)

gnupg-perms:
	@echo "Setting GnuPG permissions.."
	bash ./scripts/set_gnupg_perms.sh | tee -a $(LOGFILE)

configure-system:
	@echo "Configuring Operating System"
	bash ./scripts/configure_sys.sh | tee -a $(LOGFILE)

install-chezmoi:
	@echo "Installing chezmoi..."
	bash ./scripts/install_chezmoi.sh

install-deps:
	@echo "Installing dependencies.."
	bash ./scripts/install_deps.sh | tee -a $(LOGFILE)

install-fonts:
	@echo "Installing fonts.."
	mkdir -p ~/.local/share/fonts
	cp ./fonts/* ~/.local/share/fonts

ensure-dirs:
	@echo "Ensuring directories.."
	bash ./scripts/ensure_directories.sh | tee -a $(LOGFILE)

ensure-deps:
	@echo "Ensuring dependencies.."
	$(MAKE) install-fonts
	$(MAKE) install-deps
	$(MAKE) install-chezmoi
	$(MAKE) install-asdf

chezmoi-init:
	@echo "Initializing chezmoi..."
	$(CHEZMOI) init -S ${CURDIR} -v

chezmoi-apply:
	@echo "Applying chezmoi.."
	$(MAKE) ensure-dirs #Ensure that ~/.local/tmux/plugins exists for exemple, before downloading tpm
	$(CHEZMOI) apply --verbose --keep-going

all:
	$(MAKE) ensure-deps
	$(MAKE) start-services
	$(MAKE) install-env
	$(MAKE) conf-sys
	$(MAKE) ssh-perms
	$(MAKE) gnupg-perms
	$(MAKE) chezmoi-init
	$(MAKE) chezmoi-apply
	$(MAKE) update

first:
	$(MAKE) ensure-deps
	$(MAKE) chezmoi-init
	$(MAKE) chezmoi-apply

run:
	$(MAKE) first
	$(MAKE) update
