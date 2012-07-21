$( function(){  
    //constantly looks for click changes to dom  
    $(".pagination a").live("click",function() {  
        $(".pagination").html("Page is loading...")//loading message  
        $.get(this.href, null, null, "script");// says that any script returned by ajax request should be executed  
        return false; // so that the actual link will not be triggered  
    });  
});