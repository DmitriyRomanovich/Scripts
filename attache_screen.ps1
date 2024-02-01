#  Configuration
$global:cwd = Get-Location
$global:screenshotPath = Join-Path -Path $global:cwd -ChildPath "cypress\screenshots"

# Global Variables
$screenshotsHashtable = @{ } # Key = test name, Value = Full screenshot filename

# Authentication - Azure DevOps

$accessToken = $env:SYSTEM_ACCESSTOKEN
$teamFoundationCollectionUri = $env:SYSTEM_TEAMFOUNDATIONCOLLECTIONURI
$teamProjectId = $env:SYSTEM_TEAMPROJECTID
$buildId = $env:BUILD_BUILDID
$headers = @{ Authorization = "Bearer " + $accessToken }


# Functions

function Save-Screenshots-Hashtable {
	Write-Host "Searching for screenshots in '$($global:screenshotPath)'"

	$screenshots = Get-ChildItem -Path $screenshotPath  -Filter *.png -Recurse -File | Select-Object -Property FullName, Name
	
	foreach ($screenshot in $screenshots) {

		$testName = $screenshot.Name -replace " --", ""
		$testName = $testName -replace "  ", " "
		$testName = $testName -replace " \(failed\).png", ""

		$screenshotsHashtable[$testName] = $screenshot.FullName

		Write-Host "Found screenshot '$($screenshot)' for test '$($testName)'"
	}
##############debug ouput
Write-Host "#####hashtable count: '$($screenshotsHashtable.count)'"
Write-Host "#####hashtable count: '$($screenshotsHashtable.Keys)'"
Write-Host "#####hashtable count: '$($screenshotsHashtable.Values)'"
}

function Get-TestRuns {

	$today = Get-Date
	$tomorrow = $today.AddDays(1)
	$yesterday = $today.AddDays(-1)

	$minLastUpdatedDate = $yesterday.ToString("yyyy-MM-dd")
	$maxLastUpdatedDate = $tomorrow.ToString("yyyy-MM-dd")

	$testRunUrl = "$($teamFoundationCollectionUri)$($teamProjectId)/_apis/test/runs?api-version=5.1&minLastUpdatedDate=$($minLastUpdatedDate)&maxLastUpdatedDate=$($maxLastUpdatedDate)&buildIds=$($buildId)"
	Write-Host "Getting Test Runs from '$testRunUrl'"

	$testRunResponse = Invoke-RestMethod -Uri $testRunUrl -Headers $headers

	$allResults = 0;

	foreach ($run in $testRunResponse.value) {
		$results = Get-Test-Results -runId $run.id

		$allResults = $allResults + $results;
	}

	return $allResults
}

function Find-Screenshot-From-Test-Result {
	param($testName)
	##############debug ouput
	Write-Host "#####testName is : '$($testName)'"
	#$testName= "Smoke CI Test Should fail"
	$testName = $testName -replace "  ", " "
	Write-Host "Searching for screenshot  for '$($testName)'"

	$screenshotFilename = $screenshotsHashtable[$testName]
	
	##############debug ouput
	Write-Host "#####screenshotFilename is : " $screenshotFilename	
	

	if ($null -ne $screenshotFilename) {
		Write-Host -ForegroundColor:Green "Found screenshot '$($screenshotFilename)' matching test '$($testName)'"
	}
 else {
		Write-Host -ForegroundColor:Red "No screenshot found matching test '$($testName)'"
	}

	return $screenshotFilename
}

function Add-Attachment-To-TestResult {
	param($screenshotFilename, $testResultId)

	$screenshotFilenameWithoutPath = Split-Path $screenshotFilename -leaf

	$createTestResultsAttachmentUrl = "$teamFoundationCollectionUri$teamProjectId/_apis/test/runs/$($runId)/results/$($testResultId)/attachments?api-version=5.1-preview&outcomes=Failed"

	$base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($screenshotFilename))

	$body = @{
		fileName       = $screenshotFilenameWithoutPath
		comment        = "Attaching screenshot"
		attachmentType = "GeneralAttachment"
		stream         = $base64string
	}

	$json = $body | ConvertTo-Json

	Write-Host "Attaching screenshot by posting to '$($createTestResultsAttachmentUrl)'"

	$response = Invoke-RestMethod $createTestResultsAttachmentUrl -Headers $headers -Method Post -Body $json -ContentType "application/json"

	Write-Host "Response from posting screenshot '$($response)'"
}

function Add-AttachmentVideo-To-TestResult {
	param($screenshotFilename, $testResultId)

	$screenshotFilename = $screenshotFilename -replace "screenshots","videos"
	$screenshotFilename = Split-Path $screenshotFilename -Parent
	$screenshotFilename = $screenshotFilename -replace "\\","/"
	$screenshotFilename = $screenshotFilename + ".mp4"

	$screenshotFilenameWithoutPath = Split-Path $screenshotFilename -leaf

	$createTestResultsAttachmentUrl = "$teamFoundationCollectionUri$teamProjectId/_apis/test/runs/$($runId)/results/$($testResultId)/attachments?api-version=5.1-preview&outcomes=Failed"

	$base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($screenshotFilename))

	$body = @{
		fileName       = $screenshotFilenameWithoutPath
		comment        = "Attaching screenshot"
		attachmentType = "GeneralAttachment"
		stream         = $base64string
	}

	$json = $body | ConvertTo-Json

	Write-Host "Attaching screenshot by posting to '$($createTestResultsAttachmentUrl)'"

	$response = Invoke-RestMethod $createTestResultsAttachmentUrl -Headers $headers -Method Post -Body $json -ContentType "application/json"

	Write-Host "Response from posting screenshot '$($response)'"
}

function Get-Test-Results {
	param($runId)

	$testResultsUrl = "$teamFoundationCollectionUri$teamProjectId/_apis/test/runs/$($runId)/results?api-version=5.1&outcomes=Failed"

	Write-Host "Getting Test Results from '$($testResultsUrl)'"

	$testResultsResponse = Invoke-RestMethod -Uri $testResultsUrl -Headers $headers

	foreach ($testResult in $testResultsResponse.value) {

		Write-Host "#####Found failing test testRun.name '$($testResult.testRun.name)'"
		Write-Host "#####Found failing test automatedTestName '$($testResult.automatedTestName)'"
		Write-Host "#####Found failing test runBy.displayName '$($testResult.runBy.displayName)'"
		Write-Host "#####Found failing test runBy.uniqueName '$($testResult.runBy.uniqueName)'"
		Write-Host "#####Found failing test project.name '$($testResult.project.name)'"
		Write-Host "#####Found failing test testCase.name '$($testResult.testCase.name)'"
		Write-Host "#####Found failing test area.name '$($testResult.area.name)'"
		Write-Host "#####Found failing test testCaseTitle '$($testResult.testCaseTitle)'"
		Write-Host "#####Found failing test  '$($testResult)'"
		Write-Host "#####Found failing test automatedTestStorage '$($testResult.automatedTestStorage)'"

		$screenshotFilename = Find-Screenshot-From-Test-Result -testName $testResult.automatedTestStorage

		if ($null -ne $screenshotFilename) {
			Add-Attachment-To-TestResult -screenshotFilename $screenshotFilename -testResultId	$testResult.id
			Add-AttachmentVideo-To-TestResult -screenshotFilename $screenshotFilename -testResultId	$testResult.id
		}
	}

	Write-Host "testResultsResponse.value.Count: $($testResultsResponse.value.Count)"

	return $testResultsResponse.value.Count
}

# Entry Point
Write-Host "Azure DevOps Test Result Attacher v.0.1b"
Write-Host ""
Write-Host "AccessToken: $accessToken"
Write-Host "TeamFoundationCollectionUri: $teamFoundationCollectionUri"
Write-Host "TeamProjectId: $teamProjectId"
Write-Host "BuildId: $buildId"
Write-Host ""

Save-Screenshots-Hashtable
$failedTests = Get-TestRuns

Write-Host "Failed Tests: $($failedTests)"

$LASTEXITCODE = 0

if ($failedTests -gt 0) {
	$LASTEXITCODE = 1
}

Write-Host "Exiting with exitCode $($LASTEXITCODE)"
exit $LASTEXITCODE