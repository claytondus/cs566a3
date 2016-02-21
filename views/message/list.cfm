<cfif rc.keyExists('messages')>
  <cfoutput query="rc.messages">
    <div class="message">
      <hr/>
      <h4>#username# wrote: #title#</h4>
      <p>#message#</p>
    </div>
  </cfoutput>
</cfif>
