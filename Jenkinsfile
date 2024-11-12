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


   }
}
