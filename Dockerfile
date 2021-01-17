# ############################################################################
# Ubuntu 20.04 (Focal Fossa) Desktop minimal install — Dockerfile
#
#	Description
#	###########
#
#	An image of Ubuntu 20.04 (Focal Fossa) as installed with the 'minimal install'
#	option. This is mainly intended for upgrade related testing, e.g.:
#
#	* Backup recovery
#	* Automated system configuration
#
#	Image contents
#	##############
#
#   * Subset of packages included in minimial installation
#   * Primary user
#   * Primary user group
#   * Primary user home directory structure
#
# ############################################################################

FROM ubuntu:focal
ARG USERNAME=username
ARG USERID=1000
ARG USERPASSWORD=userpassword

RUN \
	\
	# Update apt cache
	apt-get update \
	\
	# Install (subset of) Focal desktop packages
	#
	#	Only a few of the most essential packages required for basic upgrade/recovery
	#	testing are installed. These are all included in the default installation [^1]
	#	and not removed [^2] during a minimal installation.
	#
	#	[^1]: http://releases.ubuntu.com/focal/ubuntu-20.04-desktop-amd64.manifest
	#	[^2]: https://people.canonical.com/~ubuntu-archive/seeds/ubuntu.focal/desktop.minimal-remove
	#
	&& apt-get install --yes \
		sudo \
						# For priviledge escalation
		python3 \
						# For everthing [e.g. Ansible])
		wget \
						# For fetching over HTTP [e.g. source archives]
		unzip \
						# For unpacking archives [e.g. source archives]
		gnupg \
						# For PKC [e.g. repo signature validiation]
		fontconfig \
						# For custom font configuration
		python3-apt \
						# For Ansible apt module
		dconf-cli \
						# For Ansible dconf module
		libx11-xcb1 \
		libxcb-dri3-0 \
		libxtst6 \
						# For Code OSS
	\
	# User setup
	&& adduser $USERNAME --uid $USERID \
	&& adduser $USERNAME sudo \
	&& echo "$USERNAME:$USERPASSWORD" | chpasswd \
	\
	# User home directory setup
	&& mkdir -vp /home/$USERNAME/Desktop \
	&& mkdir -vp /home/$USERNAME/Downloads \
	&& mkdir -vp /home/$USERNAME/Templates \
	&& mkdir -vp /home/$USERNAME/Public \
	&& mkdir -vp /home/$USERNAME/Documents \
	&& mkdir -vp /home/$USERNAME/Music \
	&& mkdir -vp /home/$USERNAME/Pictures \
	&& mkdir -vp /home/$USERNAME/Videos \
	\
	# Clear cache
	&& apt-get clean

USER $USERNAME
