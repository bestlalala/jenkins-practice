pipeline{
   agent any

   environment{
      DOCKERHUB_CREDENTIALS = credentials("docker-hub")
   }

   stages {
      stage("Permission"){
           steps{
               sh "chmod +x ./gradlew"
           }
       }
       stage("Compile"){
           steps{
               sh "./gradlew compileJava"
           }
       }
       stage("Test"){
           steps{
               sh "./gradlew test"
           }
       }
       stage("test coverage"){
          steps{
               sh "./gradlew test jacocoTestCoverageVerification"
               sh "./gradlew test jacocoTestReport"
          }
       }
       stage("Static Code Analysis"){
         steps{
             sh "./gradlew checkstyleMain"
                 publishHTML(target: [
                             reportDir: 'build/reports/checkstyle/',
                             reportFiles: 'main.html',
                             reportName: 'Checkstyle Report'
                 ])
         }
       }
       stage("Gradle Build"){
         steps{
             sh "./gradlew clean build"
         }
       }
       stage("Docker Image Build"){
         steps{
             sh "docker build -t bestlalala/calculator ."
         }
       }

       stage('docker hub login'){
         steps{
             sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
         }
       }

       stage('docker hub push'){
         steps{
             sh 'docker push bestlalala/calculator:latest'
         }
       }

       stage('deploy'){
          steps{
              sh "docker run -d --rm -p 8765:8080 --name calculator bestlalala/calculator"
          }
       }

       stage('acceptance test'){
         steps{
             sleep 60
             sh 'chmod +x acceptance_test.sh && ./acceptance_test.sh'
         }
       }

       post{
          always{
              sh 'docker stop calculator'
          }
       }
   }
}
