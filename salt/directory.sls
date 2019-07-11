data:
  file.directory:
    - name: /home/java/data
    - user: java
    - group: java
    - dir_mode: 640
    - require:
      - user: java

bin:
  file.directory:
    - name: /home/java/bin/jars
    - makedirs: True
    - user: java
    - group: java
    - dir_mode: 640
    - require:
      - user: java

logs:
  file.directory:
    - name: /home/java/logs
    - user: java
    - group: java
    - dir_mode: 640
    - require:
      - user: java
