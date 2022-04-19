#！！！请修改！！！！！
$SubscriptionId = "3851f1a6-e76d-4c8b-b204-0809652cbe98"
$ResourceGroupName = "avd-rg"
$StorageAccountName = "leizhangavdstorage01"
$sharename = "avduserprofile"

#Constrain the scope to the target file share
$scope = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Storage/storageAccounts/$StorageAccountName/fileServices/default/fileshares/$sharename"

#共享管理员
#Use one of the built-in roles: Storage File Data SMB Share Reader, Storage File Data SMB Share Contributor, Storage File Data SMB Share Elevated Contributor
$rolename = "Storage File Data SMB Share Elevated Contributor" 
$UPN = "avd01@leicorp.biz"
#Get the name of the custom role
$FileShareContributorRole = Get-AzRoleDefinition $rolename
#Assign the custom role to the target identity with the specified scope.
New-AzRoleAssignment -SignInName $UPN -RoleDefinitionName $FileShareContributorRole.Name -Scope $scope
#Check Assign Status
#get-AzRoleAssignment -signinname $UPN
#remove-assign
#remove-AzRoleAssignment -signinname $UPN -RoleDefinitionName $rolename -Scope $scope

#WVD用户组访问文件共享
#Assign to Group
$GroupRolename = "Storage File Data SMB Share Contributor"
$GroupFileShareContributorRole = Get-AzRoleDefinition $GroupRolename
$ObjectId = "53c78020-fcfe-40d5-ba72-5aad258461a9"
New-AzRoleAssignment -ObjectId $ObjectId -RoleDefinitionName $GroupFileShareContributorRole.Name -Scope $scope
#Check Assign Status
#get-AzRoleAssignment -ObjectId $ObjectId
#Group remove-assign
#remove-AzRoleAssignment -ObjectId $ObjectId -RoleDefinitionName $rolename -Scope $scope