# name: Push Docker Image To AWS ECR
# on:
#   push:
#     branches:
#       - 'main'

# jobs:
#   build:
#     name: Building Docker Image
#     runs-on: ubuntu-latest
#     steps:
#     - name: Check out code
#       uses: actions/checkout@v2
    
#     - name: Configure AWS credentials
#       uses: aws-actions/configure-aws-credentials@v1
#       with:
#         aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
#         aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
#         aws-region: us-east-1

#      # Log in to Amazon ECR
#     - name: Login to Amazon ECR
#       id: login-ecr
#       uses: aws-actions/amazon-ecr-login@v1

#       # Determine ECR Repository name
#     - name: Determine ECR Repository name
#       id: ecr_repository_name
#       run: |
#           if [[ $GITHUB_REF == "refs/heads/main" ]]; then
#             echo "ECR_IMAGE_NAME=next-development"  >> $GITHUB_OUTPUT
#             echo "DOCKERFILE_NAME=Dockerfile"  >> $GITHUB_OUTPUT
#           else
#             echo "The value of GITHUB_REF is $GITHUB_REF"
#             echo "::error:: Branch not supported for deployment"
#             exit 1
#           fi

#     # Output ECR Repository Name
#     - name: OutPut ECR Repository Name
#       env: 
#          ECR_IMAGE_NAME: ${{ steps.ecr_repository_name.outputs.ECR_IMAGE_NAME }}
#       run: |
#             echo " **** ECR Repository name is ${{ steps.ecr_repository_name.outputs.ECR_IMAGE_NAME }} ****"
#             echo " **** Dockerfile name is ${{ steps.ecr_repository_name.outputs.DOCKERFILE_NAME }} ****"
 
#     # Build, tag, and push the Docker image to Amazon ECR  
#     - name: Build, tag, and push image to Amazon ECR
#       env:
#         ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
#         ECR_REPOSITORY: ${{ steps.ecr_repository_name.outputs.ECR_IMAGE_NAME }}
#         DOCKFILE_NAME: ${{ steps.ecr_repository_name.outputs.DOCKERFILE_NAME }}
#         IMAGE_TAG: latest
#       run: |
#         docker build -f $DOCKFILE_NAME -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
#         docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG

#   # # Set up kubectl to interact with your EKS cluster
#   #   - name: Configure kubectl
#   #     run: |
#   #       aws eks update-kubeconfig --name <your-cluster-name> --region us-east-1

#   #   # Update Kubernetes deployment with the new image
#   #   - name: Update Kubernetes Deployment
#   #     run: |
#   #       kubectl set image deployment/nextjs-app-deployment nextjs-app=${{ steps.login-ecr.outputs.registry }}/${{ steps.ecr_repository_name.outputs.ECR_IMAGE_NAME }}:latest
