<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">
    <xsl:template match="/root" name="wurui.order-detail">
        <!-- className 'J_OXMod' required  -->
        <div class="J_OXMod oxmod-order-detail" ox-mod="order-detail" >
        	<xsl:variable name="dsid" select="substring(data/orders/attribute::ADAPTERID,2)"/>
        	<xsl:variable name="order" select="data/ecom-orders/i[1]"/>
        	<input type="hidden" value="{$order/_id}" class="J_order_id"/>

        	<xsl:variable name="status-desc">
				<xsl:choose>
					<xsl:when test="$order/actions/refund/success">退款成功</xsl:when>
					<xsl:when test="$order/actions/refund/complete/fmt_cn">退款完成</xsl:when>
					<xsl:when test="$order/actions/refund/accept/fmt_cn">退款处理中</xsl:when>
					<xsl:when test="$order/actions/refund/apply/fmt_cn">退款中</xsl:when>
					<xsl:when test="$order/actions/close/fmt_cn">订单已关闭</xsl:when>
					<xsl:when test="$order/actions/complete/fmt_cn">订单已完成</xsl:when>
					<xsl:when test="$order/actions/deliver/time/fmt_cn">已发货</xsl:when>
					<xsl:when test="$order/actions/accept/fmt_cn">商家已接单</xsl:when>
					<xsl:when test="$order/actions/pay/time/fmt_cn">已付款</xsl:when>
					<xsl:when test="$order/time/fmt_cn">待支付</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
        	<h2>订单信息</h2>

            <table>
            	<tbody>
            		<tr>
            			<th>状态</th>
            			<td>
            				<span class="status-desc"><xsl:value-of select="$status-desc" /></span>
            			</td>
            		</tr>
            		<tr>
            			<th>订单号</th>
            			<td>
            				<span class="order-id"><xsl:value-of select="$order/_id" /></span>
            			</td>
            		</tr>
            		<tr>
            			<th>描述</th>
            			<td>
            				<xsl:value-of select="$order/title" />
            			</td>
            		</tr>
            		<tr>
            			<th>总金额</th>
            			<td>
            				<big class="price"><xsl:value-of select="$order/totalfee" /></big>
            			</td>
            		</tr>
            		<tr>
            			<th>卖家</th>
            			<td>
            				<xsl:value-of select="$order/seller" />
            			</td>
            		</tr>
            		<tr>
            			<th>创建时间</th>
            			<td>
            				<xsl:value-of select="$order/time/fmt_cn" />
            			</td>
            		</tr>
            		
            	</tbody>
            </table>
            <xsl:if test="$order/actions/refund/apply/fmt_cn">
	        	<h3>退款信息</h3>
	            <table>
	            	<tbody>
	            		<tr>
	            			<th>发起时间</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/refund/apply/fmt_cn" />
	            			</td>
	            		</tr>
	            		<tr>
	            			<th>完成时间</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/refund/complete/fmt_cn" />
	            			</td>
	            		</tr>
	            		<tr>
	            			<th>交易号</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/refund/trade_no" />
	            			</td>
	            		</tr>
	            		
	            	</tbody>
	            </table>
	        </xsl:if>
            <xsl:if test="$order/delivery != ''">
	            <h3>物流信息</h3>

	            <table>
	            	<tbody>
	            		
	            		<tr>
	            			<th>收货地址</th>
	            			<td>
	            				<xsl:value-of select="$order/delivery" />
	            			</td>
	            		</tr>
	            		<xsl:if test="$order/actions/deliver/time/fmt_cn">
	            		<tr>
	            			<th>物流单号</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/deliver/no"/>
	            			</td>
	            		</tr>
	            		<tr>
	            			<th>发货时间</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/deliver/time/fmt_cn"/>
	            			</td>
	            		</tr>
	            		</xsl:if>
	            		
	            	</tbody>
	            </table>
	        </xsl:if>


            <h3>商品信息</h3>
            <table>
            	<tbody>
            		<xsl:for-each select="$order/content/i">
            		<tr>
            			<th><xsl:value-of select="name" /></th>
            			<td>
            				<span class="price"><xsl:value-of select="price" /></span>
            			</td>
            			<td>
            				&#215;<xsl:value-of select="amount" />
            			</td>
            		</tr>
            		</xsl:for-each>
            	</tbody>
            </table>

            <h3>收费明细</h3>
            <table>
            	<tbody>
            		
            		<xsl:for-each select="$order/bill/i">
            		<tr>
            			<th><xsl:value-of select="item" /></th>
            			<td>
            				<span class="price"><xsl:value-of select="value" /></span>
            			</td>
            			
            		</tr>
            		</xsl:for-each>            		
            	</tbody>
            </table>
            <xsl:if test="$order/actions/pay">
            	<h3>支付信息</h3>
	            <table>
	            	<tbody>
	            		<tr>
	            			<th>支付渠道</th>
	            			<td>
	            				<span class="paychannel-{$order/actions/pay/type}"><xsl:value-of select="$order/actions/pay/type" /></span>
	            			</td>
	            		</tr>
	            		<tr>
	            			<th>交易号</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/pay/trade_no" />
	            			</td>
	            		</tr>
	            		<tr>
	            			<th>完成时间</th>
	            			<td>
	            				<xsl:value-of select="$order/actions/pay/time/fmt_cn" />
	            			</td>
	            		</tr>
	            	</tbody>
	            </table>
	        </xsl:if>
	        <div class="operation">
	        	<xsl:choose>
					<xsl:when test="$status-desc = '退款中'">
						<button data-action="refund-cancel">取消退款</button>
					</xsl:when>
					<xsl:when test="$status-desc = '已付款'">
						<button data-action="refund-apply">申请退款</button>
					</xsl:when>
					<xsl:when test="$status-desc = '待支付'">
						<a class="buttonlike" href="http://pay.openxsl.com/p/pay/custom?dsname=orders&amp;dsid={$dsid}&amp;oid={$order/_id}">付款</a>
					</xsl:when>
					
				</xsl:choose>
	        </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
