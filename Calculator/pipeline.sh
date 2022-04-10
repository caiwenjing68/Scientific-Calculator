pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'master', url: 'https://github.com/caiwenjing68/Scientific-Calculator.git'

                // Run Maven on a Unix agent.
                sh "mvn -f /var/lib/jenkins/workspace/17643HW3/Calculator/pom.xml compile"
            }
        }

        stage('Static Analysis') {
            steps {
                // static analysis using sonarQube
                sh "mvn clean verify sonar:sonar -Dsonar.projectKey=17643hw3 -Dsonar.login=25f73db1a1354c8f7fd55894deb6fdf422b8ce5a"
            }
        }
        
        stage('Test') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn -f /var/lib/jenkins/workspace/17643HW3/Calculator/pom.xml test"
            }
        }
    }
}