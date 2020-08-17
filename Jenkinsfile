pipeline {
   agent any
   environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = "us-east-1"
    }

   stages {
      stage('Git') {
         steps {
            git 'https://github.com/rakeshragipani/node-js-sample.git'
         }
      }
      
      stage('convert to zip') {
         steps{
            sh '''
            npm install 
            zip -r master.zip ./*
            '''
         }
      }
      stage("Set Terraform path") {
		steps {
			script {
				def tfHome = tool name: 'Terraform128'
				env.PATH = "${tfHome}:${env.PATH}"
			}
			sh 'terraform --version'
		 }
	  }
      
      stage('deploy to lambda') {
          steps{
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'ed10dcb8-44af-46dd-90cc-6c368d564a97', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh '''
             if (( $(aws lambda list-functions --region us-east-1 | grep FunctionName | grep masterbranch | wc -l) > 0 ))
            #if (terraform output -json lambda_arn | jq '.value' = "arn:aws:lambda:us-east-1:246944263478:function:welcome-nodejs" )
            then
                cd lambda-tf
                terraform init
                #terraform plan -out=lambda
                terraform plan .
                terraform apply lambda
                #terraform destroy -auto-approve
            else
                cd lambda-tf
                terraform init
                terraform plan -lock=false -out=lambda
                terraform apply lambda
                #terraform destroy -auto-approve
            fi

            
            '''
         
            }
          }
      }
   }
}
