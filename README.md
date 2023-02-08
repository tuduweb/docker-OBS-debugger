### Docker-OBS-debugger

debug OBS in ubuntu 20.04.

#### STEP

1. build docker image:
    ```
    docker build -t obs-debugger-image:latest .
    ```

2. startup docker image:
    ```
    docker run -it obs-debugger-image:latest
    ```