FROM kasmweb/core:1.8.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


# Install Utilities
COPY ./src/ubuntu/install/misc $INST_SCRIPTS/misc/
RUN bash $INST_SCRIPTS/misc/install_tools.sh && rm -rf $INST_SCRIPTS/misc/

# Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Install Firefox
COPY ./src/ubuntu/install/firefox/ $INST_SCRIPTS/firefox/
COPY ./src/ubuntu/install/firefox/firefox.desktop $HOME/Desktop/
RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/

# Install Custom Certificate Authority
# COPY ./src/ubuntu/install/certificates $INST_SCRIPTS/certificates/
# RUN bash $INST_SCRIPTS/certificates/install_ca_cert.sh && rm -rf $INST_SCRIPTS/certificates/


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
