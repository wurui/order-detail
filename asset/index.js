define([],function(){
  return {
    init:function($mod){
    	$mod.on('click',function(e){
    		var tar=e.target,
    		action=tar.getAttribute('data-action');

    		switch(action){
    			case 'refund-apply':
    			//console.log('申请退款')
    			tar.setAttribute('disabled','disabled');
    			$mod.OXPut({
    				orders:{
    					'actions.refund.apply':Date.now()
    				}
    			},function(){
    				$mod.OXRefresh();

    			})

    			break
    			case 'refund-cancel':
    			tar.setAttribute('disabled','disabled');
    			$mod.OXPut({
    				orders:{
    					'actions.refund.apply':null
    				}
    			},function(){
    				$mod.OXRefresh();

    			})
    			break
    		}

    	});
    }
  }
})
