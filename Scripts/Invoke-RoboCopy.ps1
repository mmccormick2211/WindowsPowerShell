function Invoke-RoboCopy {
    param
    (
        [Parameter(Mandatory)]
        [string]$Source,

        [Parameter(Mandatory)]
        [string]$Destination,

        [string]$Filter = '*',

        [int]$RetryCount = 0,

        [string]$ExcludeDirectory = '',

        [switch]$Open,

        [switch]$FlatCopy,

        [switch]$NoRecurse
    )

    $Recurse = '/S'
    if ($NoRecurse) { $Recurse = '' }

    robocopy.exe $Source $Destination $Filter /R:$RetryCount $Recurse /XD $ExcludeDirectory

    if ($FlatCopy) {
        Get-ChildItem -Path $Destination -Recurse -Filter $Filter |
            Move-Item -Destination $Destination -Force
        Get-ChildItem -Path $Destination -Directory |
            Remove-Item -Recurse -Force
    }

    if ($Open) {
        explorer $Destination
    }
}
<#
(  SS64  )
CMD
Syntax

Search
ROBOCOPY.exe
Robust File and Folder Copy.
By default Robocopy will only copy a file if the source and destination have different time stamps or different file sizes.

Syntax
      ROBOCOPY Source_folder Destination_folder [files_to_copy] [options]

Key
   file(s)_to_copy : A list of files or a wildcard.
                          (defaults to copying *.*)

  Source options
                /S : Copy Subfolders.
                /E : Copy Subfolders, including Empty Subfolders.
 /COPY:copyflag[s] : What to COPY (default is /COPY:DAT)
                      (copyflags : D=Data, A=Attributes, T=Timestamps
                       S=Security=NTFS ACLs, O=Owner info, U=aUditing info).
              /SEC : Copy files with SECurity (equivalent to /COPY:DATS).
          /DCOPY:T : Copy Directory Timestamps.
          /COPYALL : Copy ALL file info (equivalent to /COPY:DATSOU).
           /NOCOPY : Copy NO file info (useful with /PURGE).

                /A : Copy only files with the Archive attribute set.
                /M : like /A, but remove Archive attribute from source files.
            /LEV:n : Only copy the top n LEVels of the source tree.

         /MAXAGE:n : MAXimum file AGE - exclude files older than n days/date.
         /MINAGE:n : MINimum file AGE - exclude files newer than n days/date.
                     (If n < 1900 then n = no of days, else n = YYYYMMDD date).

              /FFT : Assume FAT File Times (2-second date/time granularity).
              /256 : Turn off very long path (> 256 characters) support.

   Copy options
                /L : List only - don’t copy, timestamp or delete any files.
              /MOV : MOVe files (delete from source after copying).
             /MOVE : Move files and dirs (delete from source after copying).
               /sl : Copy symbolic links instead of the target.
                /Z : Copy files in restartable mode (survive network glitch).
                /B : Copy files in Backup mode.
                /J : Copy using unbuffered I/O (recommended for large files). ##
        /NOOFFLOAD : Copy files without using the Windows Copy Offload mechanism. ##
               /ZB : Use restartable mode; if access denied use Backup mode.
            /IPG:n : Inter-Packet Gap (ms), to free bandwidth on slow lines.

              /R:n : Number of Retries on failed copies - default is 1 million.
              /W:n : Wait time between retries - default is 30 seconds.
              /REG : Save /R:n and /W:n in the Registry as default settings.
              /TBD : Wait for sharenames To Be Defined (retry error 67).

   Destination options

    /A+:[RASHCNET] : Set file Attribute(s) on destination files + add.
    /A-:[RASHCNET] : UnSet file Attribute(s) on destination files - remove.
              /FAT : Create destination files using 8.3 FAT file names only.

           /CREATE : CREATE directory tree structure + zero-length files only.
              /DST : Compensate for one-hour DST time differences.
            /PURGE : Delete dest files/folders that no longer exist in source.
              /MIR : MIRror a directory tree - equivalent to /PURGE plus all subfolders (/E)

   Logging options
                /L : List only - don’t copy, timestamp or delete any files.
               /NP : No Progress - don’t display % copied.
          /unicode : Display the status output as Unicode text.   #
         /LOG:file : Output status to LOG file (overwrite existing log).
      /UNILOG:file : Output status to Unicode Log file (overwrite)
        /LOG+:file : Output status to LOG file (append to existing log).
     /UNILOG+:file : Output status to Unicode Log file (append)
               /TS : Include Source file Time Stamps in the output.
               /FP : Include Full Pathname of files in the output.
               /NS : No Size - don’t log file sizes.
               /NC : No Class - don’t log file classes.
              /NFL : No File List - don’t log file names.
              /NDL : No Directory List - don’t log directory names.
              /TEE : Output to console window, as well as the log file.
              /NJH : No Job Header.
              /NJS : No Job Summary.

 Repeated Copy Options
            /MON:n : MONitor source; run again when more than n changes seen.
            /MOT:m : MOnitor source; run again in m minutes Time, if changed.

     /RH:hhmm-hhmm : Run Hours - times when new copies can be started.
               /PF : Check run hours on a Per File (not per pass) basis.

 Job Options
      /JOB:jobname : Take parameters from the named JOB file.
     /SAVE:jobname : SAVE parameters to the named job file
             /QUIT : QUIT after processing command line (to view parameters).
             /NOSD : NO Source Directory is specified.
             /NODD : NO Destination Directory is specified.
               /IF : Include the following Files.

Advanced options you'll probably never use
           /EFSRAW : Copy any encrypted files using EFS RAW mode.
           /MT[:n] : Multithreaded copying, n = no. of threads to use (1-128)  #
                     default = 8 threads, not compatible with /IPG and /EFSRAW
                     The use of /LOG is recommended for better performance.

           /SECFIX : FIX file SECurity on all files, even skipped files.
           /TIMFIX : FIX file TIMes on all files, even skipped files.

               /XO : eXclude Older - if destination file exists and is the same date
                     or newer than the source - don’t bother to overwrite it.
               /XC : eXclude Changed files
               /XN : eXclude Newer files
               /XL : eXclude "Lonely" files and dirs (present in source but not destination)
                     This will prevent any new files being added to the destination.
               /XX : eXclude "eXtra" files and dirs (present in destination but not source)
                     This will prevent any deletions from the destination. (this is the default)

/XF file [file]... : eXclude Files matching given names/paths/wildcards.
/XD dirs [dirs]... : eXclude Directories matching given names/paths.
                     XF and XD can be used in combination  e.g.
                     ROBOCOPY c:\source d:\dest /XF *.doc *.xls /XD c:\unwanted /S

   /IA:[RASHCNETO] : Include files with any of the given Attributes
   /XA:[RASHCNETO] : eXclude files with any of the given Attributes
               /IS : Include Same, overwrite files even if they are already the same.
               /IT : Include Tweaked files.
               /XJ : eXclude Junction points. (normally included by default).
              /XJD : Exclude junction points for directories. #
              /XJF : Exclude junction points for files.      #

            /MAX:n : MAXimum file size - exclude files bigger than n bytes.
            /MIN:n : MINimum file size - exclude files smaller than n bytes.
         /MAXLAD:n : MAXimum Last Access Date - exclude files unused since n.
         /MINLAD:n : MINimum Last Access Date - exclude files used since n.
                     (If n < 1900 then n = n days, else n = YYYYMMDD date).

            /BYTES : Print sizes as bytes.
                /X : Report all eXtra files, not just those selected & copied.
                /V : Produce Verbose output log, showing skipped files.
              /ETA : Show Estimated Time of Arrival of copied files.
            /DEBUG : Show debug volume information (undocumented)
# = New Option in Windows 7 and Windows 2008 R2
## = New Option in Windows 8 and Windows 10
In Windows XP, Robocopy was only available via the Resource Kit but is a standard/built in command since Windows 7.

Robocopy EXIT CODES

File Attributes [RASHCNETO]

 R – Read only
 A – Archive
 S – System
 H – Hidden
 C – Compressed
 N – Not content indexed
 E – Encrypted
 T – Temporary
 O - Offline
By copying only the files that have changed, robocopy can be used to backup very large volumes.

If either the source or desination are a "quoted long foldername" do not include a trailing backslash as this will be treated as an escape character, i.e. "C:\some path\" will fail but "C:\some path\\" or "C:\some path\." or "C:\some path" will work.

If creating a progress logfile with /LOG , specify a destination directory that already exists, robocopy will create the file but will not create a log directory automatically.

ROBOCOPY will accept UNC pathnames including UNC pathnames over 256 characters long.

/REG Writes to the registry at HKCU\Software\Microsoft\ResKit\Robocopy

/XX (exclude extra) If used in conjunction with /Purge or /Mir, this switch will take precedence and prevent any files being deleted from the destination.

To limit the network bandwidth used by robocopy, specify the Inter-Packet Gap parameter /IPG:n
This will send packets of 64 KB each followed by a delay of n Milliseconds.

Robocopy will fail to copy files that are locked by other users or applications, so limiting the number of retries with /R:0 will speed up copying by skipping any in-use files. The Windows Volume Shadow Copy service is the only Windows subsystem that can copy open files. Robocopy does not use the Volume Shadow Copy service, but it can backup a volume shadow that has already been created with VSHADOW or DISKSHADOW.

All versions of Robocopy will copy security information (ACLs) for directories, version XP010 will not copy file security changes unless the file itself has also changed, this greatly improves performance.

/B (backup mode) will allow Robocopy to override file and folder permission settings (ACLs).

ERROR 5 (0x00000005) Changing File Attributes ... Access is denied
This error usually means that File/Folder permissions or Share permissions on either the source or the destination are preventing the copy, either change the permissions or run the command in backup mode with /B.

To run ROBOCOPY under a non-administrator account will require backup files privilege, to copy security information auditing privilege is also required, plus of course you need at least read access to the files and folders.

Examples:

Simple copy of all files from one folder to another:

ROBOCOPY \\Server1\reports \\Server2\backup
Copy all .jpg and .bmp files from one folder to another:

ROBOCOPY \\Server1\reports \\Server2\backup *.jpg *.bmp
Copy files including subfolders (even empty ones /E)
If this command is run repeatedly it will skip any files already in the destination, however it is not a true mirror as any files deleted from the source will remain in the destination.

ROBOCOPY \\Server1\reports \\Server2\backup *.* /E
List files over 32 MBytes in size:

ROBOCOPY C:\work /MAX:33554432 /L
Move files over 14 days old: (note the MOVE option will fail if any files are open and locked.)

ROBOCOPY C:\work C:\destination /move /minage:14
Backup a Server:
The script below copies data from FileServ1 to FileServ2, the destination holds a full mirror along with file security info. When run regularly to synchronize the source and destination, robocopy will only copy those files that have changed (change in time stamp or size.)

@ECHO OFF
SETLOCAL

SET _source=\\FileServ1\e$\users

SET _dest=\\FileServ2\e$\BackupUsers

SET _what=/COPYALL /B /MIR
:: /COPYALL :: COPY ALL file info
:: /B :: copy files in Backup mode.
:: /MIR :: MIRror a directory tree

SET _options=/R:0 /W:0 /LOG:C:\batch\RoboLog.txt /NFL /NDL
:: /R:n :: number of Retries
:: /W:n :: Wait time between retries
:: /LOG :: Output log file
:: /NFL :: No file logging
:: /NDL :: No dir logging

ROBOCOPY %_source% %_dest% %_what% %_options%

Run two robocopy jobs at the same time with START /Min

Start /Min "Job one" Robocopy \\FileServA\C$\Database1 \\FileServeBackupA\c$\Backups
Start /Min "Job two" Robocopy \\FileServB\C$\Database2 \\FileServeBackupB\c$\Backups
Copy only permission changes (additions and removals) assuming we already have a copy of the data:
ROBOCOPY \\FileServer\C$ \\SVR-Backups\c$\Backups /E /Copy:S /IS /IT

Availability
Robocopy XP027 is a standard command in Windows 7 and above. The Windows Server 2003 Resource Kit Tools include Robocopy XP010, which can be run on NT 4/ Windows 2000. Robocopy does not run on Windows 95, or NT 3.5. (Robocopy is a Unicode application).
The Microsoft Robocopy GUI will install Robocopy XP026 to C:\Windows\system32, this version can can run on older OS's, and includes some features from XP027 (/BYTES) but has competely broken errorlevel handling.

Robocopy 'Jobs' and the 'MOnitor source' option provide an alternative to setting up a Scheduled Task to run a batchfile with a Robocopy command.

Bugs
The Windows 7 /Server 2008 R2 version of Robocopy will incorrectly skip some files if the filenames contain East Asian characters, for example Japanese characters. A hotfix is available to correct this KB2680906

Robocopy /MOVE or /PURGE can be used to delete empty folders by setting source and destination to the same folder, but this does not always deal with nested empty folders in a single pass. It will work if Windows Explorer is closed.

Version XP026 returns a success errorlevel even when it fails.

“One, a robot may not injure a human being, or through inaction, allow a human being to come to harm” - Isaac Asimov, Laws of Robotics from I. Robot, 1950

Related:

Robocopy EXIT CODES
DiskShadow - Copy open files (Shadow copies)
COPY - Copy one or more files to another location
Robocopy GUI - Technet magazine (installs Robocopy XP026)
RichCopy free GUI copy utility - Ken Tamaru @ Microsoft
DelTree - Delete subfolders and files / delete empty folders.
Convert KB/MB - Bits and Bytes, bandwidth calculations
Q323275 - Copy Security info without copying files (/SECFIX or /COPY:S)
Equivalent bash command:rsync - Remote file copy (Synchronize file trees)



 Copyright © SS64.com 1999-2017
Some rights reserved
 #>