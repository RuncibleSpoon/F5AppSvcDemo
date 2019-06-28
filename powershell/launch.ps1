# Script to Launch an CFT with paramters etc 
# First parameter
$p1 = new-object Amazon.CloudFormation.Model.Parameter
$p1.ParameterKey = "KeyName"
$p1.ParameterValue = "AAAWS"
# Second Parameter
$p2 = new-object Amazon.CloudFormation.Model.Parameter
$p2.ParameterKey = "S3Bucket"
$p2.ParameterValue = "<your S3 Bucket name>"
# Call New-CFNStack with paramters 
$stack =  New-CFNStack -StackName MyF5Lab -Capability CAPABILITY_NAMED_IAM  -TemplateURL <template location> -Parameters @( $p1, $p2 )