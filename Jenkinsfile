def dockerRun = "sudo docker run -it -p 95:80 -d --name HCL-Hack42 chika1984/myapp:21.4.2"
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
		//stage ('SonarQube Analysis') {
	      //steps {
		  //withSonarQubeEnv('sonar-1') {
		  //sh "/usr/share/maven/bin/mvn sonar:sonar"
		  //}
        //}       
       //}
        stage ('Build Maven') {
            steps {
                //sh 'mvn -Dmaven.test.failure.ignore=true install' 
				//def mvnHome = tool name: 'maven', type 'maven'
				sh 'mvn clean package'
            }
          }	   
        stage('Build Docker image') {
		  agent { label 'master' }
		  	  
         steps {
			sh 'docker build -t chika1984/myapp:21.4.2 .'

			}
		}	
		
		stage('Push Docker image') {
		agent { label 'master' }
		 steps {
			withCredentials([string(credentialsId: 'DockerHub-Login', variable: 'DockerHubPwd')]) {
            sh "docker login -u chika1984 -p ${DockerHubPwd}"
			}
			sh 'docker push chika1984/myapp:21.4.2'
		} 	
		}
		 stage('Run Docker image on HCL-Hack Server') {
		 steps {
		    sshagent(['HCL-CodeHack']){ 
			sh "ssh -o StrictHostKeyChecking=no ubuntu@13.233.151.145 ${dockerRun}"		 
		 }
        
}
}
}
}