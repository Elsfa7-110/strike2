echo -e "\nFinding URLs for $1 using Waybackurls ...."

    echo "$1" | waybackurls | tee "$1".txt >/dev/null 2>&1;
    printf "URLS fetched using waybackurls & Stored in $blue$1.txt$end"
    printf "\n\nFinding URLs for $1 using gau ....\n"
    echo "$1" | gau | tee -a $1.txt >/dev/null 2>&1;
    printf "URLS fetched using gau & appended in $blue$1.txt$end \n\n"

    echo -e "\nFinding valid URLs for XSS using GF Patterns \n"

    cat "$1".txt | gf xss | sed 's/=.*/=/' | sed 's/URL: //' | tee "$1"_temp_xss.txt >/dev/null 2>&1;

    sort "$1"_temp_xss.txt | uniq | tee "$1"_xss.txt >/dev/null 2>&1;
    printf "\nXSS Vulnerable URL's added to $blue"$1"_xss.txt$end\n\n"
    
    echo "XSS Automation Started using Dalfox.."
    
    python3 xsstrike.py --seeds "$1"_xss.txt --blind --params -t 500
