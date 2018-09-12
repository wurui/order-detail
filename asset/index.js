define([],function(){
  return {
    init:function($mod){
    	var order_id=$('.J_order_id',$mod).val();
    	$mod.on('click',function(e){
    		var tar=e.target,
    		action=tar.getAttribute('data-action');

    		switch(action){
    			case 'refund-apply':
    			//console.log('申请退款')
    			tar.setAttribute('disabled','disabled');
    			$mod.OXPut({
    				orders:{
    					_id:order_id,
    					//'actions.refund.apply':Date.now()
    					$updater:'refundapply'
    				}
    			},function(r){
    				var result=r && r[0]
                    if(result.error){
                        OXJS.toast('提交失败：'+result.error)
                    }else{
                    	$mod.OXRefresh();	
                    }

    			})

    			break
    			case 'refund-cancel':
    			tar.setAttribute('disabled','disabled');
    			$mod.OXPut({
    				orders:{
    					_id:order_id,
    					$updater:'refundcancel'
    				}
    			},function(r){
    				
    				var result=r && r[0]
                    if(result.error){
                        OXJS.toast('提交失败：'+result.error)
                    }else{
                    	$mod.OXRefresh();	
                    }
    				

    			})
    			break
    		}

    	});
    }
  }
})
