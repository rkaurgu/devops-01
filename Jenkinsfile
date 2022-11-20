pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        // publish artifacts to nexus
        stage('publish to nexus') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'ssvkart5devops', classifier: '', file: 'target/ssvkart5devops-0.0.2-SNAPSHOT.war', type: 'war']], credentialsId: '05229c50-64ff-4683-97b0-58a4c41a2f78', groupId: 'com.ssvkart5lab', nexusUrl: '23.20.105.10:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'ssvkart5devopslab-SNAPSHOT', version: 'SNAPSHOT-0.0.2
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}