def dockerRun = "sudo docker run -it -p 8096:80 -d --name HCL-Hack96 chika1984/myapp:96.1.0"
pipeline {
  agent any
    tools {
        maven 'maven'
        jdk 'jdk'
    }
      stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
					echo 'this **********'
                    '''
            }
        }
		stage ('SonarQube Analysis') {
	      steps {
		  withSonarQubeEnv('sonar-2') {
		  sh "/usr/share/maven/bin/mvn sonar:sonar"
		  }
        }       
       }
        stage ('Build Maven') {
            steps {
                //sh 'mvn -Dmaven.test.failure.ignore=true install' 
				//def mvnHome = tool name: 'maven', type 'maven'
				sh 'mvn clean test'
            }
          }	   
        stage('Build Docker image') {
		  agent { label 'master' }
		  	  
         steps {
			sh 'docker build -t chika1984/myapp:96.1.0 .'

			}
		}	
		
		stage('Push Docker image') {
		agent { label 'master' }
		 steps {
			withCredentials([string(credentialsId: 'DockerHub-Login', variable: 'DockerHubPwd')]) {
            sh "docker login -u chika1984 -p ${DockerHubPwd}"
			}
			sh 'docker push chika1984/myapp:96.1.0'
		} 	
		}
		 stage('Run Docker image on HCL-Hack Server') {
		 steps {
		    sshagent(['HCL-Hack-Code']){ 
			sh "ssh -o StrictHostKeyChecking=no ubuntu@65.1.110.54 ${dockerRun}"		 
		 }
        
}
}
}
}