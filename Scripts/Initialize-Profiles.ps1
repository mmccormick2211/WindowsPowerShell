# Creates profiles if doesn't exist
function Initialize-Profiles {
    if (!(Test-Path -Path $PROFILE.AllUsersAllHosts)) { New-Item -Path $PROFILE.AllUsersAllHosts -ItemType File -Force }
    if (!(Test-Path -Path $PROFILE.AllUsersCurrentHost)) { New-Item -Path $PROFILE.AllUsersCurrentHost -ItemType File -Force }
    if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts)) { New-Item -Path $PROFILE.CurrentUserAllHosts -ItemType File -Force }
    if (!(Test-Path -Path $PROFILE.CurrentUserCurrentHost)) { New-Item -Path $PROFILE.CurrentUserCurrentHost -ItemType File -Force }
}
Initialize-Profiles
