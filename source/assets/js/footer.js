$(function(){
   $('#linkSobre').click(function(){
       var url = 'about';
       $(location).attr('href', url);
       return false;
   });
});