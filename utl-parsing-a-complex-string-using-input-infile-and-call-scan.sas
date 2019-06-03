Parsing a complex string using input infile and call scan                                           
                                                                                                    
How to get around multiple delimiters at the beginning of a string.                                 
                                                                                                    
No need for Klingon regular expression?                                                             
                                                                                                    
Good question nice answer                                                                           
                                                                                                    
                                                                                                    
https://communities.sas.com/t5/New-SAS-User/Unable-to-read-data/m-p/563118                          
                                                                                                    
https://communities.sas.com/t5/user/viewprofilepage/user-id/18408                                   
                                                                                                    
/*                                                                                                  
CALL SCAN(<string>, count, position, length <, <character-list> <, <modifier(s)>>>);                
*/                                                                                                  
                                                                                                    
*_                   _                                                                              
(_)_ __  _ __  _   _| |_                                                                            
| | '_ \| '_ \| | | | __|                                                                           
| | | | | |_) | |_| | |_                                                                            
|_|_| |_| .__/ \__,_|\__|                                                                           
        |_|                                                                                         
;                                                                                                   
 _infile_ = VSKP GARIB RATH(12740)  20:30 04:06 07:36                                               
                                                                                                    
                                                                                                    
call scan(_infile_,-3,p,l,' ');                                                                     
                                                                                                    
*            _               _                                                                      
  ___  _   _| |_ _ __  _   _| |_                                                                    
 / _ \| | | | __| '_ \| | | | __|                                                                   
| (_) | |_| | |_| |_) | |_| | |_                                                                    
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                   
                |_|                                                                                 
;                                                                                                   
                                                                                                    
                                                                                                    
Up to 40 obs WORK.WANT total obs=1                                                                  
                                                                                                    
                                                     TOTAL_                                         
Obs          TRAIN_NAME          ARRIVAL     DEPT     HOURS                                         
                                                                                                    
 1     VSKP GARIB RATH(12740)     73800     14760     27360                                         
                                                                                                    
*                                                                                                   
 _ __  _ __ ___   ___ ___  ___ ___                                                                  
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                 
| |_) | | | (_) | (_|  __/\__ \__ \                                                                 
| .__/|_|  \___/ \___\___||___/___/                                                                 
|_|                                                                                                 
;                                                                                                   
                                                                                                    
                                                                                                    
data want;                                                                                          
                                                                                                    
   input;                                                                                           
                                                                                                    
   * get the position of  "2" in  "20:30 04:06 07:36";                                              
   * this eliminates the delimiter problem when parsing left to right;                              
                                                                                                    
   call scan(_infile_,-3,position,length,' ');                                                      
   put position=; /* 25 */                                                                          
   put length=;   /* 5  "20:30" */                                                                  
                                                                                                    
   * substr 1 to 24 is "VSKP GARIB RATH(12740)  " avoids multiple delimiters;                       
   train_name=substr(_infile_,1,position-1);                                                        
                                                                                                    
   arrival     = input(scan(_infile_,-3,' '),time5.);                                               
   dept        = input(scan(_infile_,-2,' '),time5.);                                               
   total_hours = input(scan(_infile_,-1,' '),time5.);                                               
                                                                                                    
   drop position length;                                                                            
                                                                                                    
   format arrival dept total_hours time5.;                                                          
datalines;                                                                                          
VSKP GARIB RATH(12740)  20:30 04:06 07:36                                                           
;;;;                                                                                                
run;quit;                                                                                           
                                                                                                    
