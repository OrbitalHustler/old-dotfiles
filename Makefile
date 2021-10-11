LOGFILE=/tmp/dotfiles.log
CHEZMOI=~/.local/bin/chezmoi

default: run
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
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

update:
	./scripts/asdf/update_asdf_plugins.sh
	~/.tmux/plugins/tpm/bin/install_plugins
	~/.tmux/plugins/tpm/bin/update_plugins all
	zinit self-update
	zinit update --parallel

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
	$(MAKE) install-chezmoi
	$(MAKE) install-fonts
	$(MAKE) install-deps

chezmoi-init:
	@echo "Initializing chezmoi..."
	$(CHEZMOI) init -S ${CURDIR} -v

chezmoi-apply:
	@echo "Applying chezmoi.."
	$(CHEZMOI) apply -v

all:
	$(MAKE) ensure-deps
	$(MAKE) start-services
	$(MAKE) install-env
	$(MAKE) conf-sys
	$(MAKE) ssh-perms
	$(MAKE) gnupg-perms
	$(MAKE) chezmoi-init
	$(MAKE) ensure-dirs
	$(MAKE) chezmoi-apply

run:
	$(MAKE) ensure-deps
	$(MAKE) chezmoi-init
	$(MAKE) chezmoi-apply
