def pullImage(imageName, tag, dockerRegistry, dockerRegistrySecretId){
    def image
    docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
        image = docker.image("${imageName}:${tag}")
        try { image.pull() } catch(err) { true }
    }
    return image
}

def pushImage(image, tag, dockerRegistry, dockerRegistrySecretId){
    docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
        image.push(tag)
    }
}

def compose(composeArgs, dockerRegistry, dockerRegistrySecretId){
    docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
        sh "docker-compose ${composeArgs}"
    }
}

def buildDockerImageWithSimpleCache(
    imageName,
    imageTag,
    imageBuildCommand,
    dockerRegistry,
    dockerRegistrySecretId = ''){
        def image
        pullImage(imageName, "latest", dockerRegistry, dockerRegistrySecretId)
        image = docker.build(imageName, "--cache-from ${imageName}:latest " + imageBuildCommand)
        pushImage(image, imageTag, dockerRegistry, dockerRegistrySecretId)
        pushImage(image, "latest", dockerRegistry, dockerRegistrySecretId)
        return image
}

node(label: 'docker') {
    def dockerRegistrySecretId = '45d995a9-803d-4dce-9f16-a39165e867ea'
    def registryPrefix = "registry.aleph.engineering"
    def dockerRegistry = "https://${registryPrefix}"
    def tag = "${env.GIT_BRANCH}-${env.BUILD_ID}"
    def buildPrefix = "--build-arg LIZARD_DIST_REPOSITORY=${registryPrefix}/lizardfs-dist:${tag} --build-arg LIZARD_BASE_REPOSITORY=${registryPrefix}/lizardfs-base:${tag} "

    stage('Clone repository') {
        checkout scm
    }

    stage('Clone build sources') {
        dir('vendors/lizardfs') {
            git branch: 'master', url: 'https://github.com/lizardfs/lizardfs.git'
        }
    }

    stage('Build: base images') {
        parallel 'dist':{
            stage('Image: dist') {
                def imageName = "${registryPrefix}/lizardfs-dist"
                def imageBuildCommand = "-f services/lizardfs-dist/Dockerfile ."

                pullImage(imageName, "builder", dockerRegistry, dockerRegistrySecretId)
                def builderImage = docker.build("${imageName}:builder", "--target build-stage --cache-from ${imageName}:builder " + imageBuildCommand)

                pullImage(imageName, "latest", dockerRegistry, dockerRegistrySecretId)
                def distImage = docker.build("${imageName}:${tag}", "--cache-from ${imageName}:builder --cache-from ${imageName}:latest " + imageBuildCommand)

                pushImage(distImage, tag, dockerRegistry, dockerRegistrySecretId)
                pushImage(distImage, "latest", dockerRegistry, dockerRegistrySecretId)
                pushImage(builderImage, "builder", dockerRegistry, dockerRegistrySecretId)
            }
        },
        'base':{
            stage('Image: base') {
                def imageName = "${registryPrefix}/lizardfs-base"
                def imageBuildCommand = "./services/lizardfs-base"
                buildDockerImageWithSimpleCache(imageName, tag, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
            }
        }
    }


    stage("Build: lizardfs modules") {
        def branchedStages = [:]
        stage_names = ["master", "cgiserv", "chunkserver", "metalogger", "client"]
        stage_names.each { STAGE_NAME ->
            branchedStages["${STAGE_NAME}"] = {
                stage("Module: ${STAGE_NAME}") {
                    def imageName = "${registryPrefix}/lizardfs-${STAGE_NAME}"
                    def imageBuildCommand = buildPrefix + "./services/lizardfs-${STAGE_NAME}"
                    buildDockerImageWithSimpleCache(imageName, tag, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
                }
            }
        }
        parallel branchedStages
    }

    stage("Start: lizardfs test-suites") {
        def branchedStages = [:]
        stage_names = ["lfs-test-suite1"]
        stage_names.each { STAGE_NAME ->
            branchedStages["${STAGE_NAME}"] = {
                stage("Start: ${STAGE_NAME}") {
                    docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
                        sh "docker-compose -f test-suite/${STAGE_NAME}/docker-compose.yml down"
                        sh "docker-compose -f test-suite/${STAGE_NAME}/docker-compose.yml up -d"
                    }
                }
            }
        }
        parallel branchedStages
    }
}
