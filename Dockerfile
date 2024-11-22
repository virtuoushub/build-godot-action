FROM barichello/godot-ci:latest

LABEL "com.github.actions.name"="Build Godot"
LABEL "com.github.actions.description"="Build a Godot project for multiple platforms"
LABEL "com.github.actions.icon"="loader"
LABEL "com.github.actions.color"="blue"

USER root
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
