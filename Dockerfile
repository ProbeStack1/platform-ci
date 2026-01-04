# ---------- Base OS ----------
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# ---------- System Utilities ----------
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    jq \
    ca-certificates \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# ---------- Java 17 ----------
RUN apt-get update && apt-get install -y openjdk-17-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# ---------- Maven ----------
RUN apt-get update && apt-get install -y maven

# ---------- Node.js (for ApigeeLint & JSON Lint) ----------
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# ---------- ApigeeLint ----------
RUN npm install -g apigeelint

# ---------- JSON Lint ----------
RUN npm install -g jsonlint

# ---------- Sonar Scanner ----------
RUN curl -L -o sonar.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip \
    && unzip sonar.zip \
    && mv sonar-scanner-* /opt/sonar-scanner \
    && rm sonar.zip

ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV PATH=$SONAR_SCANNER_HOME/bin:$PATH

# ---------- Apigee CLI (Management API) ----------
RUN curl -L https://raw.githubusercontent.com/apigee/apigeecli/main/downloadLatest.sh | sh - \
    && mv apigeecli /usr/local/bin/apigeecli

# ---------- Fortify (Customer-Provided Binary) ----------
# Fortify cannot be redistributed.
# Copy your licensed Fortify installation during build if needed.
# Example:
# COPY fortify /opt/fortify
# ENV PATH=/opt/fortify/bin:$PATH

# ---------- Work Directory ----------
WORKDIR /workspace

# ---------- Default Command ----------
CMD ["/bin/bash"]
