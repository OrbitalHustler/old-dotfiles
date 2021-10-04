LOGFILE=/tmp/dotfiles.log

default: run
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
	@echo '    make update             Update configs: zsh, tmux.'
	@echo
	@echo '    make start-services     Starts services (systemd...).'
	@echo '    make install-env        Install environment.'
	@echo '    make conf-sys           Configure system files.'
	@echo '    make ssh-perms          Set SSH permissions.'
	@echo '    make gnupg-perms        Set GnuPG permissions.'
	@echo '    make os-defaults        Configure OS defaults'
	@echo '    make ensure-deps        Install all dependencies.'
	@echo '    make chezmoi-init       Initialize chezmoi.'
	@echo '    make chezmoi-apply      Apply chezmoi files (runs all scripts).'
	@echo '    make post-chezmoi       Run post chezmoi scripts.'
	@echo '    make install-chezmoi    Install chezmoi.'
	@echo '    make install-deps       Install system dependencies.'
	@echo '    make ensure-dirs        Creates required directories.'
	@echo
	@echo
	@echo '    make run                Ensure deps and apply chezmoi.'
	@echo '    make all                Run all.'
	@echo
	@echo '    Logs are stored in      $(LOGFILE)'

update:
	~/.tmux/plugins/tpm/bin/install_plugins
	~/.tmux/plugins/tpm/bin/update_plugins all
	zinit self-update
	zinit update --parallel

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

install-chezmoi:
	@echo "Installing chezmoi..."
	bash ./scripts/install_chezmoi.sh

install-deps:
	@echo "Installing dependencies.."
	bash ./scripts/install_deps.sh | tee -a $(LOGFILE)

ensure-dirs:
	@echo "Ensuring directories.."
	bash ./scripts/ensure_directories.sh | tee -a $(LOGFILE)

ensure-deps:
	@echo "Ensuring dependencies.."
	$(MAKE) install-chezmoi
	$(MAKE) install-deps

chezmoi-init:
	@echo "Initializing chezmoi..."
	~/.local/bin/chezmoi init -S ${CURDIR} -v

chezmoi-apply:
	@echo "Applying chezmoi.."
	~/.local/bin/chezmoi apply -v

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
