#!groovy​
def appName = 'petclinic'
def appServicePort = '8080'
def builderImage = 'maven:latest'

node () {
    stage ('Checkout'){
        echo 'Checking out git repository'
        checkout scm
    }
    wf.builder(builderImage) {
        stage ('Compile') {
            wf.mvn("compile")
        }
    }
    stage ('Code QA') {
        wf.codeQAwithConfigFile()
    }
    wf.builder(builderImage) {
        stage ('Build Package') {
            wf.mvn("-DskipTests clean package")
        }
        stage ('Test Package') {
            wf.mvn("verify")
        }
        stage ('Push Package') {
            wf.mvnSnapshotPush("-DskipTests deploy")
        }
    }
    stage ('Build Image') {
        wf.imageBuild(appName)
    }
    stage ('Test Image') {
        wf.imageRun {
            sh 'echo Testing the image...'
        }
    }
    stage ('Promote staging'){
        wf.imagePromote('staging')
    }
    stage('Approval') {
        wf.imageDeployForApproval(appServicePort)
    }
    stage('Promote stable') {
        wf.imagePromote('stable')
    }
}
