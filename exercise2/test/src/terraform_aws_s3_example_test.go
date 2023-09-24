package test

import (
	"fmt"
	// "strings"
	"testing"

	// "github.com/gruntwork-io/terratest/modules/aws"
	// "github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"time"
)

const (
	awsRegion = "us-east-1"	

)

func TestRecipeSimple(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../",
		Upgrade: false,
		VarFiles: []string{"config/terraform.tfvars"},
		Vars: map[string]interface{}{
			"aws_region": "aws_region",
			"environment": "environment",
			"owner": "owner",
			"project": "project",
			"bucket_name": "bucket_name",
		},
		
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucketName := terraform.Output(t, terraformOptions, "bucket_id")
	bucketARN := terraform.Output(t, terraformOptions, "bucket_arn")

	t.Logf ("Bucket name: %s", bucketName)
	t.Logf ("Bucket ARN: %s", bucketARN)

	assert.NotNil(t, bucketName)
	assert.NotNil(t, bucketARN)
	
	time.Sleep(40 * time.Second)
	fmt.Println("Sleep Over.....")

}
