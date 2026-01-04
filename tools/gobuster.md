Gobuster GitHub repository : https://github.com/OJ/gobuster

specific wordlists and handling the incoming responses. Many security professionals use this tool for penetration testing, bug bounty hunting, and cyber security assessments. Looking at the phases of ethical hacking, we can place Gobuster between the reconnaissance and scanning phases.

Before exploring Gobuster, let’s briefly discuss the concepts of enumeration and Brute Force.

Enumeration

Enumeration is the act of listing all the available resources, whether they are accessible or not. For example, Gobuster enumerates web directories.

Brute Force

Brute force is the act of trying every possibility until a match is found. It is like having ten keys and trying them all on a lock until one fits. Gobuster uses wordlists for this purpose.

Gobuster: Overview
Gobuster is included by default in distributions like Kali Linux. Let’s start by looking at Gobuster’s help page. This help page gives us a good overview of its functionalities and options.

Enter the following command: gobuster --help. You should get the help page for the Gobuster tool as shown below:

AttackBox Terminal
root@tryhackme:~# gobuster --help
Usage:
  gobuster [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  dir         Uses directory/file enumeration mode
  dns         Uses DNS subdomain enumeration mode
  fuzz        Uses fuzzing mode. Replaces the keyword FUZZ in the URL, Headers and the request body
  gcs         Uses gcs bucket enumeration mode
  help        Help about any command
  s3          Uses aws bucket enumeration mode
  tftp        Uses TFTP enumeration mode
  version     shows the current version
  vhost       Uses VHOST enumeration mode (you most probably want to use the IP address as the URL parameter)

Flags:
      --debug                 Enable debug output
      --delay duration        Time each thread waits between requests (e.g. 1500ms)
  -h, --help                  help for gobuster
      --no-color              Disable color output
      --no-error              Don't display errors
  -z, --no-progress           Don't display progress
  -o, --output string         Output file to write results to (defaults to stdout)
  -p, --pattern string        File containing replacement patterns
  -q, --quiet                 Don't print the banner and other noise
  -t, --threads int           Number of concurrent threads (default 10)
  -v, --verbose               Verbose output (errors)
  -w, --wordlist string       Path to the wordlist. Set to - to use STDIN.
      --wordlist-offset int   Resume from a given position in the wordlist (defaults to 0)

Use "gobuster [command] --help" for more information about a command.
The help page contains multiple sections:

Usage: Shows the syntax on how to use the command.
Available Commands: Multiple commands are available to aid us in enumerating directories, files, DNS subdomains, Google Cloud Storage buckets, and Amazon AWS S3 buckets. Throughout this room, we will focus on the dir, dns, and vhost commands. We will cover each of them in the following tasks.
Flags: These are specific options we can configure to customize our commands. Let’s look at the flags we will often use throughout this room:
Short Flag	Long Flag	Description
-t	--threads	This flag configures the number of threads to use for the scan. Each of these threads sends out requests with a slight delay. The default number of threads is 10. This number may be slow when using large wordlists. You can increase or decrease the number of threads depending on the available system resources.
-w	--wordlist	The flag configures a wordlist to use for iterating. Each wordlist entry is attached to the URL you included in the command.
--delay	This flag defines the amount of time to wait between sending requests. Some web servers include mechanisms to detect enumeration by looking at how many requests are received in a certain period of time. We can increase the delay between subsequent requests to make it look like normal web traffic.
--debug	This flag helps us to troubleshoot when our command gives unexpected errors.
-o	--output	This flag writes the enumeration results to a file we choose.
Example
Let us look at an example of how we would use these commands and flags together to enumerate a web directory:

gobuster dir -u "http://www.example.thm/" -w /usr/share/wordlists/dirb/small.txt -t 64
gobuster dir indicates that we will use the directory and file enumeration mode.
-u "http://www.example.thm/" tells Gobuster that the target URL is http://example.thm/.
-w /usr/share/wordlists/dirb/small.txt directs Gobuster to use the small.txt wordlist to brute force the web directories. Gobuster will use each entry in the wordlist to form a new URL and send a GET request to that URL. If the first entry of the wordlist were images, Gobuster would send a GET request to http://example.thm/images/.
-t 64 sets the number of threads Gobuster will use to 64. This improves the performance drastically.
Now that we have a quick overview of Gobuster, let’s explore the different modes and their use cases in the following tasks.

Gobuster has a dir mode, allowing users to enumerate website directories and their files. This mode is useful when you are performing a penetration test and would like to see what the directory structure of a website is and what files it contains. Often, directory structures of websites and web apps follow a particular convention, making them susceptible to Brute Force using wordlists. For example, the  directory structure on the web server hosting WordPress looks something  like this:

AttackBox Terminal
root@tryhackme:~# tree -L 3 -d
.
└── html
    └── wordpress
        ├── wp-admin
        ├── wp-content
        └── wp-includes
Gobuster is powerful because it allows you to scan the website and return the status codes. These status codes immediately tell you if you, as an outside user, can request that directory or not.

Help
If you want a complete overview of what the Gobuster dir command can offer, you can look at the help page. Seeing the extensive help page for the dir command can somewhat be intimidating. So, we will focus on the most essential flags in this room. Type the following command to display the help: gobuster dir --help.

Many flags are used to fine-tune the gobuster dir command. It is out of scope to go over each one of them, but in the table below, we have listed the flags that cover most of the scenarios:

Flag	Long Flag	Description
-c	--cookies	This flag configures a cookie to pass along each request, such as a session ID.
-x	--extensions	This flag specifies which file extensions you want to scan for. E.g., .php, .js
-H	--headers	This flag configures an entire header to pass along with each request.
-k	--no-tls-validation	This flag  skips the process that checks the certificate when https is used. It often happens for CTF events or test rooms like the ones on THM a self-signed certificate is used. This causes an error during the TLS check.
-n	--no-status	You can set this flag when you don’t want to see status codes of each response received. This helps keep the output on the screen clear.
-P	password	You can set this flag together with the --username flag to execute authenticated requests. This is handy when you have obtained credentials from a user.
-s	--status-codes	With this flag, you can configure which status codes of the received responses you want to display, such as 200, or a range like 300-400.
-b	--status-codes-blacklist	This flag allows you to configure which status codes of the received responses you don’t want to display. Configuring this flag overrides the -s flag.
-U	--username	You can set this flag together with the --password flag to execute authenticated requests. This is handy when you have obtained credentials from a user.
-r	--followredirect	This flags configures Gobuster to follow the redirect that it received as a response to the sent request. A HTTP redirect status code (e.g., 301 or 302) is used to redirect the client to a different URL.
How To Use dir Mode
To run Gobuster in dir mode, use the following command format:

gobuster dir -u "http://www.example.thm" -w /path/to/wordlist

Notice that the command also includes the flags -u and -w, in addition to the dir keyword. These two flags are required for the Gobuster directory enumeration to work. Let us look at a practical example of how to enumerate directories and files with Gobuster dir mode:

gobuster dir -u "http://www.example.thm" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -r

This command scans all the directories located at www.example.thm using the wordlist directory-list-2.3-medium.txt. Let’s look a bit closer at each part of the command:

gobuster dir: Configures Gobuster to use the directory and file enumeration mode.
-u http://www.example.thm:
The URL will be the base path where Gobuster starts looking. So, the URL  above is using the root web directory. For example, in a typical Apache installation on Linux, this is /var/www/html. So if you have a “resources” directory and you want to enumerate that directory, you’d set the URL as http://www.example.thm/resources. You can also think of this like http://www.example.thm/path/to/folder.
The URL must contain the protocol used, in this case, HTTP. This is important and required. If you pass the wrong protocol, the scan will fail.
In the host part of the URL, you can either fill in the IP or the HOSTNAME. However, it is important to mention that when using the IP, you may target a different website than intended. A web server can host multiple websites using one IP (this technique is also called virtual hosting). Use the HOSTNAME if you want to be sure.
Gobuster does not enumerate recursively. So, if the results show a directory path you are interested in, you will have to enumerate that specific directory.
-w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt configures Gobuster to use the directory-list-2.3-medium.txt wordlist to enumerate. Each entry of the wordlist is appended to the configured URL.
-r configures Gobuster to follow the redirect responses received from the sent requests. If a status code 301 was received, Gobuster will navigate to the redirect URL that is included in the response.
Let’s look at a second example where we use the -x flag to specify what type of files we want to enumerate:

gobuster dir -u "http://www.example.thm" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.js

This command will look for directories located at http://example.thm using the wordlist directory-list-2.3-medium.txt. In addition to directory listing, this command also lists all the files that have a .php or .js extension.
