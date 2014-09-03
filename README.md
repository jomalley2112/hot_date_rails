 Unfinished Project!

 Setup
 Instructions
 In application.js need to add //=require hot_date_rails
 In application.css need to add  *=require hot_date_rails


NOTES:
 see if we can/should add these to hot_date_rails too
//= require jquery
//= require jquery_ujs


---
| Option         | DatePicker | TimePicker | DatetimePicker |
---
| dateFormat     |     X      |            |       X        |
| timeFormat*    |            |     X      |       X        |
| altTimeFormat* |            |     X      |       X        |
| hourGrid       |            |     X      |       X        |
| minuteGrid     |            |     X      |       X        |
| secondGrid     |            |     X      |       X        |
| changeMonth    |     X      |            |       ?        |
| changeYear     |     X      |            |       ?        |
| timeOnly       |            |     ?      |       X        |


\* *timeFormat & altTimeFormat should probably be set to the same value*

