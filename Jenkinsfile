
node('master') {

  try {
    notifyBuild('STARTED')
    deleteDir()

    stage('checkout') {
      checkout scm
    }

    def buildEnv = docker.image('ruby:latest')
    buildEnv.pull()
    buildEnv.inside {
      stage('D/L dependencies') {
        sh "bundle"
      }

      stage('Build') {
        if (env.BRANCH_NAME == 'master') {
        sh "JEKYLL_ENV=production jekyll build"
        } else {
          sh "JEKYLL_ENV=production jekyll build --config '_config.yml,_config_dev.yml'"
        }

        archive '_site/**'

        stash includes: '_site/**', name: 'built-site'
      }
    }

    if (currentBuild.result == 'UNSTABLE') {
      throw 'Skipping deployment due to unstable build'
    } else {
      stage('Deploy') {
        node() {
          deleteDir()
          unstash 'built-site'
          if (env.BRANCH_NAME == 'master') {
            sh "aws s3 sync --exclude 'branches/*' --delete _site/ s3://blog.brightcrowd.com/"
          } else {
            sh "aws s3 sync --delete _site/ s3://blog.brightcrowd.com/branches/${env.BRANCH_NAME}/"
          }
        }
      }
    }

  } catch (e) {
    // If there was an exception thrown, the build failed
    currentBuild.result = "FAILED"
    throw e
  } finally {
    // Success or failure, always send notifications
    notifyBuild(currentBuild.result)
  }
}


def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL}console)"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary, tokenCredentialId: 'slackToken')
}
