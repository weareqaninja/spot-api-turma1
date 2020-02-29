pipeline {
   agent {
       docker {
           image "ruby"
       }
   }

   stages {
      stage('Build') {
         steps {
            echo 'Building or resolve dependencies!'
            sh 'bundle install'
         }
      }
      stage('Tests') {
         steps {
            echo 'Running api tests'
            sh 'AMBIENTE=hmg rspec -t smoke'
            post {
               always {
                  junit 'logs/report.xml'
               }
            }  
         } 
      }
      stage('UAT') {
         steps {
            echo 'Wait for User Acceptance Testing'
            input(message: 'Go to production?', ok: 'Yes')
         } 
      }
      stage('Prod') {
          steps {
             echo 'Api is Ready :)'
          }
      }
   }
}
