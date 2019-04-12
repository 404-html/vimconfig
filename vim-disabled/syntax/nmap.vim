" Vim syntax file
" Language:	Lua 4.0, Lua 5.0 and Lua 5.1
" Maintainer:	Ron Bowes
" First Author:	Ron Bowes
" Last Change:	2010 Oct 16

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword nseTodo             contained TODO FIXME XXX
syn match   nseComment          "--.*$" contains=nseTodo,@Spell
syn region  nseComment        matchgroup=nseComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=nseTodo,@Spell

" First line may start with #!
syn match nseComment "\%^#!.*"

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region nseParen transparent start='(' end=')' contains=ALLBUT,nseError,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseCondStart,nseBlock,nseRepeatBlock,nseRepeat,nseStatement
syn match  nseError ")"
syn match  nseError "}"
syn match  nseError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region nseFunctionBlock transparent matchgroup=nseFunction start="\<function\>" end="\<end\>" contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat

" if then else elseif end
syn keyword nseCond contained else

" then ... end
syn region nseCondEnd contained transparent matchgroup=nseCond start="\<then\>" end="\<end\>" contains=ALLBUT,nseTodo,nseSpecial,nseRepeat

" elseif ... then
syn region nseCondElseif contained transparent matchgroup=nseCond start="\<elseif\>" end="\<then\>" contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat

" if ... then
syn region nseCondStart transparent matchgroup=nseCond start="\<if\>" end="\<then\>"me=e-4 contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat nextgroup=nseCondEnd skipwhite skipempty

" do ... end
syn region nseBlock transparent matchgroup=nseStatement start="\<do\>" end="\<end\>" contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat

" repeat ... until
syn region nseRepeatBlock transparent matchgroup=nseRepeat start="\<repeat\>" end="\<until\>" contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat

" while ... do
syn region nseRepeatBlock transparent matchgroup=nseRepeat start="\<while\>" end="\<do\>"me=e-2 contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseRepeat nextgroup=nseBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region nseRepeatBlock transparent matchgroup=nseRepeat start="\<for\>" end="\<do\>"me=e-2 contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd nextgroup=nseBlock skipwhite skipempty

" Following 'else' example. This is another item to those
" contains=ALLBUT,... because only the 'for' nseRepeatBlock contains it.
syn keyword nseRepeat contained in

" other keywords
syn keyword nseStatement return local break
syn keyword nseOperator  and or not
syn keyword nseConstant  nil
syn keyword nseConstant true false

" Strings
syn match  nseSpecial contained "\\[\\abfnrtv\'\"]\|\\\d\{,3}"
syn region nseString2 matchgroup=nseString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
syn region nseString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=nseSpecial,@Spell
syn region nseString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=nseSpecial,@Spell

" integer number
syn match nseNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match nseFloat  "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match nseFloat  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match nseFloat  "\<\d\+e[-+]\=\d\+\>"

" hex numbers
syn match nseNumber "\<0x\x\+\>"

" tables
syn region  nseTableBlock transparent matchgroup=nseTable start="{" end="}" contains=ALLBUT,nseTodo,nseSpecial,nseCond,nseCondElseif,nseCondEnd,nseCondStart,nseBlock,nseRepeatBlock,nseRepeat,nseStatement

syn keyword nseFunc assert collectgarbage dofile error next
syn keyword nseFunc print rawget rawset tonumber tostring type _VERSION

" Not sure if all these functions need to be highlighted...
syn keyword nseFunc _G getfenv getmetatable ipairs loadfile
syn keyword nseFunc loadstring pairs pcall rawequal
syn keyword nseFunc require setfenv setmetatable unpack xpcall
syn keyword nseFunc load module select
syn match   nseFunc /package\.cpath/
syn match   nseFunc /package\.loaded/
syn match   nseFunc /package\.loadlib/
syn match   nseFunc /package\.path/
syn match   nseFunc /package\.preload/
syn match   nseFunc /package\.seeall/
syn match   nseFunc /coroutine\.running/
syn match   nseFunc /coroutine\.create/
syn match   nseFunc /coroutine\.resume/
syn match   nseFunc /coroutine\.status/
syn match   nseFunc /coroutine\.wrap/
syn match   nseFunc /coroutine\.yield/
syn match   nseFunc /string\.byte/
syn match   nseFunc /string\.char/
syn match   nseFunc /string\.dump/
syn match   nseFunc /string\.find/
syn match   nseFunc /string\.len/
syn match   nseFunc /string\.lower/
syn match   nseFunc /string\.rep/
syn match   nseFunc /string\.sub/
syn match   nseFunc /string\.upper/
syn match   nseFunc /string\.format/
syn match   nseFunc /string\.gsub/
syn match   nseFunc /string\.gmatch/
syn match   nseFunc /string\.match/
syn match   nseFunc /string\.reverse/
syn match   nseFunc /table\.maxn/
syn match   nseFunc /table\.concat/
syn match   nseFunc /table\.sort/
syn match   nseFunc /table\.insert/
syn match   nseFunc /table\.remove/
syn match   nseFunc /math\.abs/
syn match   nseFunc /math\.acos/
syn match   nseFunc /math\.asin/
syn match   nseFunc /math\.atan/
syn match   nseFunc /math\.atan2/
syn match   nseFunc /math\.ceil/
syn match   nseFunc /math\.sin/
syn match   nseFunc /math\.cos/
syn match   nseFunc /math\.tan/
syn match   nseFunc /math\.deg/
syn match   nseFunc /math\.exp/
syn match   nseFunc /math\.floor/
syn match   nseFunc /math\.log/
syn match   nseFunc /math\.log10/
syn match   nseFunc /math\.max/
syn match   nseFunc /math\.min/
syn match   nseFunc /math\.fmod/
syn match   nseFunc /math\.modf/
syn match   nseFunc /math\.cosh/
syn match   nseFunc /math\.sinh/
syn match   nseFunc /math\.tanh/
syn match   nseFunc /math\.pow/
syn match   nseFunc /math\.rad/
syn match   nseFunc /math\.sqrt/
syn match   nseFunc /math\.frexp/
syn match   nseFunc /math\.ldexp/
syn match   nseFunc /math\.random/
syn match   nseFunc /math\.randomseed/
syn match   nseFunc /math\.pi/
syn match   nseFunc /io\.stdin/
syn match   nseFunc /io\.stdout/
syn match   nseFunc /io\.stderr/
syn match   nseFunc /io\.close/
syn match   nseFunc /io\.flush/
syn match   nseFunc /io\.input/
syn match   nseFunc /io\.lines/
syn match   nseFunc /io\.open/
syn match   nseFunc /io\.output/
syn match   nseFunc /io\.popen/
syn match   nseFunc /io\.read/
syn match   nseFunc /io\.tmpfile/
syn match   nseFunc /io\.type/
syn match   nseFunc /io\.write/
syn match   nseFunc /os\.clock/
syn match   nseFunc /os\.date/
syn match   nseFunc /os\.difftime/
syn match   nseFunc /os\.execute/
syn match   nseFunc /os\.exit/
syn match   nseFunc /os\.getenv/
syn match   nseFunc /os\.remove/
syn match   nseFunc /os\.rename/
syn match   nseFunc /os\.setlocale/
syn match   nseFunc /os\.time/
syn match   nseFunc /os\.tmpname/
syn match   nseFunc /debug\.debug/
syn match   nseFunc /debug\.gethook/
syn match   nseFunc /debug\.getinfo/
syn match   nseFunc /debug\.getlocal/
syn match   nseFunc /debug\.getupvalue/
syn match   nseFunc /debug\.setlocal/
syn match   nseFunc /debug\.setupvalue/
syn match   nseFunc /debug\.sethook/
syn match   nseFunc /debug\.traceback/
syn match   nseFunc /debug\.getfenv/
syn match   nseFunc /debug\.getmetatable/
syn match   nseFunc /debug\.getregistry/
syn match   nseFunc /debug\.setfenv/
syn match   nseFunc /debug\.setmetatable/

" Functions in the form, 'function aaa(...)':
"  export TAB=`echo -ne '\t'`; for i in *.lua; do i=`echo "$i" | sed s/\.lua//`; cat $i.lua | grep function | grep -v local | grep -v -- '--' | egrep -v '^ ' | egrep -v "^$TAB" | grep '^function' | sed -r "s/function ([a-zA-Z0-9_-:]+).*/$i\\.\1/" | egrep '^[a-zA-Z0-9._-:]+$' | sed -r 's/\./\\./g' | sed -r 's/(.*)/syn match   nseFunc \/\1\//'; done
"
" Functions in the form, "aaa = function(...)":
" export TAB=`echo -ne '\t'`; for i in *.lua; do i=`echo "$i" | sed s/\.lua//`; cat $i.lua | grep function | grep -v local | grep -v -- '--' | egrep -v '^ ' | egrep -v "^$TAB" | grep -v '^function' | sed -r "s/^([a-zA-Z0-9_-:]+).*function.*/$i\\.\1/" | egrep '^[a-zA-Z0-9._-]+$'  | sed -r 's/\./\\./g' | sed -r 's/(.*)/syn match   nseFunc \/\1\//'; done
syn match   nseFunc /comm\.get_banner/
syn match   nseFunc /comm\.exchange/
syn match   nseFunc /datafiles\.parse_protocols/
syn match   nseFunc /datafiles\.parse_rpc/
syn match   nseFunc /datafiles\.parse_services/
syn match   nseFunc /datafiles\.parse_mac_prefixes/
syn match   nseFunc /datafiles\.get_array/
syn match   nseFunc /datafiles\.get_assoc_array/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.answerFetcher/
syn match   nseFunc /dns\.additionalFetcher/
syn match   nseFunc /dns\.additionalFetcher/
syn match   nseFunc /dns\.additionalFetcher/
syn match   nseFunc /dns\.additionalFetcher/
syn match   nseFunc /dns\.decoder/
syn match   nseFunc /dns\.decoder/
syn match   nseFunc /dns\.decoder/
syn match   nseFunc /dns\.decoder/
syn match   nseFunc /dns\.get_default_timeout/
syn match   nseFunc /http\.generic_request/
syn match   nseFunc /http\.request/
syn match   nseFunc /http\.get/
syn match   nseFunc /http\.get_url/
syn match   nseFunc /http\.head/
syn match   nseFunc /http\.post/
syn match   nseFunc /http\.pipeline/
syn match   nseFunc /http\.parse_www_authenticate/
syn match   nseFunc /http\.get_default_timeout/
syn match   nseFunc /ipOps\.isPrivate/
syn match   nseFunc /ipOps\.todword/
syn match   nseFunc /ipOps\.fromdword/
syn match   nseFunc /ipOps\.get_parts_as_number/
syn match   nseFunc /ipOps\.compare_ip/
syn match   nseFunc /ipOps\.ip_in_range/
syn match   nseFunc /ipOps\.expand_ip/
syn match   nseFunc /ipOps\.get_ips_from_range/
syn match   nseFunc /ipOps\.get_last_ip/
syn match   nseFunc /ipOps\.ip_to_bin/
syn match   nseFunc /ipOps\.bin_to_ip/
syn match   nseFunc /ipOps\.hex_to_bin/
syn match   nseFunc /ldap\.tagEncoder/
syn match   nseFunc /ldap\.tagDecoder/
syn match   nseFunc /ldap\.tagDecoder/
syn match   nseFunc /match\.regex/
syn match   nseFunc /match\.numbytes/
syn match   nseFunc /shortport\.port_is_excluded/
syn match   nseFunc /shortport\.portnumber/
syn match   nseFunc /shortport\.service/
syn match   nseFunc /shortport\.port_or_service/
syn match   nseFunc /shortport\.version_port_or_service/
syn match   nseFunc /snmp\.tagEncoder/
syn match   nseFunc /snmp\.tagEncoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /snmp\.tagDecoder/
syn match   nseFunc /ssh1\.check_packet_length/
syn match   nseFunc /ssh1\.receive_ssh_packet/
syn match   nseFunc /ssh1\.fetch_host_key/
syn match   nseFunc /ssh1\.fingerprint_hex/
syn match   nseFunc /ssh1\.fingerprint_bubblebabble/
syn match   nseFunc /ssh1\.fingerprint_visual/
syn match   nseFunc /ssh2\.check_packet_length/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.transport/
syn match   nseFunc /ssh2\.fetch_host_key/
syn match   nseFunc /stdnse\.print_debug/
syn match   nseFunc /target\.add/
syn match   nseFunc /unpwdb\.timelimit/
syn match   nseFunc /unpwdb\.usernames/
syn match   nseFunc /unpwdb\.passwords/
syn match   nseFunc /asn1\.BERtoInt/
syn match   nseFunc /asn1\.intToBER/
syn match   nseFunc /base64\.enc/
syn match   nseFunc /base64\.dec/
syn match   nseFunc /citrixxml\.decode_xml_document/
syn match   nseFunc /citrixxml\.send_citrix_xml_request/
syn match   nseFunc /citrixxml\.request_server_farm_data/
syn match   nseFunc /citrixxml\.parse_server_farm_data_response/
syn match   nseFunc /citrixxml\.request_appdata/
syn match   nseFunc /citrixxml\.parse_appdata_response/
syn match   nseFunc /citrixxml\.request_address/
syn match   nseFunc /citrixxml\.request_server_data/
syn match   nseFunc /citrixxml\.parse_server_data_response/
syn match   nseFunc /citrixxml\.request_protocol_info/
syn match   nseFunc /citrixxml\.request_capabilities/
syn match   nseFunc /citrixxml\.parse_capabilities_response/
syn match   nseFunc /citrixxml\.request_validate_credentials/
syn match   nseFunc /citrixxml\.parse_validate_credentials_response/
syn match   nseFunc /citrixxml\.request_reconnect_session_data/
syn match   nseFunc /comm\.tryssl/
syn match   nseFunc /datafiles\.parse_file/
syn match   nseFunc /datafiles\.parse_lines/
syn match   nseFunc /datafiles\.read_from_file/
syn match   nseFunc /dhcp\.make_request/
syn match   nseFunc /dns\.query/
syn match   nseFunc /dns\.reverse/
syn match   nseFunc /dns\.findNiceAnswer/
syn match   nseFunc /dns\.findNiceAdditional/
syn match   nseFunc /dns\.encode/
syn match   nseFunc /dns\.decStr/
syn match   nseFunc /dns\.decode/
syn match   nseFunc /dns\.newPacket/
syn match   nseFunc /dns\.addQuestion/
syn match   nseFunc /http\.buildCookies/
syn match   nseFunc /http\.pGet/
syn match   nseFunc /http\.pHead/
syn match   nseFunc /http\.parse_date/
syn match   nseFunc /http\.get_status_string/
syn match   nseFunc /http\.can_use_head/
syn match   nseFunc /http\.can_use_get/
syn match   nseFunc /http\.identify_404/
syn match   nseFunc /http\.page_exists/
syn match   nseFunc /imap\.capabilities/
syn match   nseFunc /json\.generate/
syn match   nseFunc /json\.Json:new/
syn match   nseFunc /json\.Json:next/
syn match   nseFunc /json\.Json:eatWhiteSpace/
syn match   nseFunc /json\.Json:jumpTo/
syn match   nseFunc /json\.Json:peek/
syn match   nseFunc /json\.Json:hasMore/
syn match   nseFunc /json\.Json:assertStr/
syn match   nseFunc /json\.Json:syntaxerror/
syn match   nseFunc /json\.Json:errors/
syn match   nseFunc /json\.Json:parseStart/
syn match   nseFunc /json\.Json:parseValue/
syn match   nseFunc /json\.Json:parseObject/
syn match   nseFunc /json\.Json:parseArray/
syn match   nseFunc /json\.Json:parseUnicodeEscape/
syn match   nseFunc /json\.Json:parseString/
syn match   nseFunc /json\.parse/
syn match   nseFunc /json\.test/
syn match   nseFunc /ldap\.encode/
syn match   nseFunc /ldap\.decode/
syn match   nseFunc /ldap\.encodeLDAPOp/
syn match   nseFunc /ldap\.searchRequest/
syn match   nseFunc /ldap\.bindRequest/
syn match   nseFunc /ldap\.unbindRequest/
syn match   nseFunc /ldap\.createFilter/
syn match   nseFunc /ldap\.searchResultToTable/
syn match   nseFunc /ldap\.extractAttribute/
syn match   nseFunc /listop\.is_empty/
syn match   nseFunc /listop\.is_list/
syn match   nseFunc /listop\.map/
syn match   nseFunc /listop\.apply/
syn match   nseFunc /listop\.filter/
syn match   nseFunc /listop\.car/
syn match   nseFunc /listop\.cdr/
syn match   nseFunc /listop\.ncar/
syn match   nseFunc /listop\.ncdr/
syn match   nseFunc /listop\.cons/
syn match   nseFunc /listop\.append/
syn match   nseFunc /listop\.reverse/
syn match   nseFunc /listop\.flatten/
syn match   nseFunc /mongodb\.toBson/
syn match   nseFunc /mongodb\.isPacketComplete/
syn match   nseFunc /mongodb\.fromBson/
syn match   nseFunc /mongodb\.testBson/
syn match   nseFunc /mongodb\.MongoData:addUnsignedInt32/
syn match   nseFunc /mongodb\.MongoData:addString/
syn match   nseFunc /mongodb\.MongoData:addBSON/
syn match   nseFunc /mongodb\.MongoData:data/
syn match   nseFunc /mongodb\.lastErrorQuery/
syn match   nseFunc /mongodb\.serverStatusQuery/
syn match   nseFunc /mongodb\.opTimeQuery/
syn match   nseFunc /mongodb\.listDbQuery/
syn match   nseFunc /mongodb\.buildInfoQuery/
syn match   nseFunc /mongodb\.isPacketComplete/
syn match   nseFunc /mongodb\.query/
syn match   nseFunc /mongodb\.queryResultToTable/
syn match   nseFunc /mongodb\.test/
syn match   nseFunc /msrpc\.start_smb/
syn match   nseFunc /msrpc\.stop_smb/
syn match   nseFunc /msrpc\.bind/
syn match   nseFunc /msrpc\.call_lanmanapi/
syn match   nseFunc /msrpc\.srvsvc_ShareType_tostr/
syn match   nseFunc /msrpc\.srvsvc_netshareenumall/
syn match   nseFunc /msrpc\.srvsvc_netsharegetinfo/
syn match   nseFunc /msrpc\.srvsvc_netsessenum/
syn match   nseFunc /msrpc\.srvsvc_netservergetstatistics/
syn match   nseFunc /msrpc\.srvsvc_netpathcompare/
syn match   nseFunc /msrpc\.srvsvc_netpathcanonicalize/
syn match   nseFunc /msrpc\.samr_PasswordProperties_tostr/
syn match   nseFunc /msrpc\.samr_AcctFlags_tostr/
syn match   nseFunc /msrpc\.samr_connect4/
syn match   nseFunc /msrpc\.samr_enumdomains/
syn match   nseFunc /msrpc\.samr_lookupdomain/
syn match   nseFunc /msrpc\.samr_opendomain/
syn match   nseFunc /msrpc\.samr_enumdomainusers/
syn match   nseFunc /msrpc\.samr_querydisplayinfo/
syn match   nseFunc /msrpc\.samr_querydomaininfo2/
syn match   nseFunc /msrpc\.samr_enumdomainaliases/
syn match   nseFunc /msrpc\.samr_lookupnames/
syn match   nseFunc /msrpc\.samr_openalias/
syn match   nseFunc /msrpc\.samr_getmembersinalias/
syn match   nseFunc /msrpc\.samr_close/
syn match   nseFunc /msrpc\.lsa_openpolicy2/
syn match   nseFunc /msrpc\.lsa_lookupnames2/
syn match   nseFunc /msrpc\.lsa_lookupsids2/
syn match   nseFunc /msrpc\.lsa_close/
syn match   nseFunc /msrpc\.lsa_SidType_tostr/
syn match   nseFunc /msrpc\.winreg_openhku/
syn match   nseFunc /msrpc\.winreg_openhklm/
syn match   nseFunc /msrpc\.winreg_openhkpd/
syn match   nseFunc /msrpc\.winreg_openhkcu/
syn match   nseFunc /msrpc\.winreg_enumkey/
syn match   nseFunc /msrpc\.winreg_openkey/
syn match   nseFunc /msrpc\.winreg_queryinfokey/
syn match   nseFunc /msrpc\.winreg_queryvalue/
syn match   nseFunc /msrpc\.winreg_closekey/
syn match   nseFunc /msrpc\.svcctl_openscmanagera/
syn match   nseFunc /msrpc\.svcctl_openscmanagerw/
syn match   nseFunc /msrpc\.svcctl_closeservicehandle/
syn match   nseFunc /msrpc\.svcctl_createservicew/
syn match   nseFunc /msrpc\.svcctl_deleteservice/
syn match   nseFunc /msrpc\.svcctl_openservicew/
syn match   nseFunc /msrpc\.svcctl_startservicew/
syn match   nseFunc /msrpc\.svcctl_controlservice/
syn match   nseFunc /msrpc\.svcctl_queryservicestatus/
syn match   nseFunc /msrpc\.atsvc_jobadd/
syn match   nseFunc /msrpc\.samr_enum_users/
syn match   nseFunc /msrpc\.samr_enum_groups/
syn match   nseFunc /msrpc\.lsa_enum_users/
syn match   nseFunc /msrpc\.get_user_list/
syn match   nseFunc /msrpc\.get_domains/
syn match   nseFunc /msrpc\.service_create/
syn match   nseFunc /msrpc\.service_start/
syn match   nseFunc /msrpc\.service_stop/
syn match   nseFunc /msrpc\.service_delete/
syn match   nseFunc /msrpc\.get_server_stats/
syn match   nseFunc /msrpc\.enum_shares/
syn match   nseFunc /msrpc\.get_share_info/
syn match   nseFunc /msrpc\.RRAS_marshall_RequestBuffer/
syn match   nseFunc /msrpc\.RRAS_SubmitRequest/
syn match   nseFunc /msrpc\.DNSSERVER_Query/
syn match   nseFunc /msrpc\.get_pad/
syn match   nseFunc /msrpc\.random_crap/
syn match   nseFunc /msrpcperformance\.get_performance_data/
syn match   nseFunc /msrpctypes\.string_to_unicode/
syn match   nseFunc /msrpctypes\.unicode_to_string/
syn match   nseFunc /msrpctypes\.marshall_array/
syn match   nseFunc /msrpctypes\.marshall_unicode/
syn match   nseFunc /msrpctypes\.marshall_ascii/
syn match   nseFunc /msrpctypes\.marshall_unicode_ptr/
syn match   nseFunc /msrpctypes\.marshall_ascii_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_unicode/
syn match   nseFunc /msrpctypes\.unmarshall_unicode_ptr/
syn match   nseFunc /msrpctypes\.marshall_unicode_array/
syn match   nseFunc /msrpctypes\.marshall_unicode_array_ptr/
syn match   nseFunc /msrpctypes\.marshall_int64/
syn match   nseFunc /msrpctypes\.marshall_int32/
syn match   nseFunc /msrpctypes\.marshall_int32_array/
syn match   nseFunc /msrpctypes\.marshall_int16/
syn match   nseFunc /msrpctypes\.marshall_int8/
syn match   nseFunc /msrpctypes\.unmarshall_int64/
syn match   nseFunc /msrpctypes\.unmarshall_int32/
syn match   nseFunc /msrpctypes\.unmarshall_int16/
syn match   nseFunc /msrpctypes\.unmarshall_int8/
syn match   nseFunc /msrpctypes\.marshall_int64_ptr/
syn match   nseFunc /msrpctypes\.marshall_int32_ptr/
syn match   nseFunc /msrpctypes\.marshall_int16_ptr/
syn match   nseFunc /msrpctypes\.marshall_int8_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_int32_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_int16_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_int8_ptr/
syn match   nseFunc /msrpctypes\.marshall_int8_array/
syn match   nseFunc /msrpctypes\.unmarshall_int8_array/
syn match   nseFunc /msrpctypes\.marshall_int8_array_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_int8_array_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_int32_array/
syn match   nseFunc /msrpctypes\.unmarshall_int32_array_ptr/
syn match   nseFunc /msrpctypes\.marshall_NTTIME/
syn match   nseFunc /msrpctypes\.unmarshall_NTTIME/
syn match   nseFunc /msrpctypes\.marshall_NTTIME_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_NTTIME_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_SYSTEMTIME/
syn match   nseFunc /msrpctypes\.unmarshall_hyper/
syn match   nseFunc /msrpctypes\.unmarshall_raw/
syn match   nseFunc /msrpctypes\.marshall_policy_handle/
syn match   nseFunc /msrpctypes\.unmarshall_policy_handle/
syn match   nseFunc /msrpctypes\.unmarshall_dom_sid2/
syn match   nseFunc /msrpctypes\.unmarshall_dom_sid2_ptr/
syn match   nseFunc /msrpctypes\.marshall_dom_sid2/
syn match   nseFunc /msrpctypes\.marshall_lsa_String/
syn match   nseFunc /msrpctypes\.marshall_lsa_String_array/
syn match   nseFunc /msrpctypes\.marshall_lsa_String_array2/
syn match   nseFunc /msrpctypes\.marshall_lsa_SidType/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_SidType/
syn match   nseFunc /msrpctypes\.lsa_SidType_tostr/
syn match   nseFunc /msrpctypes\.marshall_lsa_LookupNamesLevel/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_LookupNamesLevel/
syn match   nseFunc /msrpctypes\.lsa_LookupNamesLevel_tostr/
syn match   nseFunc /msrpctypes\.marshall_lsa_TransSidArray2/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_RefDomainList/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_RefDomainList_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_TransSidArray2/
syn match   nseFunc /msrpctypes\.marshall_lsa_QosInfo/
syn match   nseFunc /msrpctypes\.marshall_lsa_ObjectAttribute/
syn match   nseFunc /msrpctypes\.marshall_lsa_SidArray/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_SidPtr/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_SidArray/
syn match   nseFunc /msrpctypes\.marshall_lsa_TransNameArray2/
syn match   nseFunc /msrpctypes\.unmarshall_lsa_TransNameArray2/
syn match   nseFunc /msrpctypes\.marshall_winreg_AccessMask/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_AccessMask/
syn match   nseFunc /msrpctypes\.winreg_AccessMask_tostr/
syn match   nseFunc /msrpctypes\.marshall_winreg_Type/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_Type/
syn match   nseFunc /msrpctypes\.marshall_winreg_Type_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_Type_ptr/
syn match   nseFunc /msrpctypes\.winreg_Type_tostr/
syn match   nseFunc /msrpctypes\.marshall_winreg_StringBuf/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_StringBuf/
syn match   nseFunc /msrpctypes\.marshall_winreg_StringBuf_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_StringBuf_ptr/
syn match   nseFunc /msrpctypes\.marshall_winreg_String/
syn match   nseFunc /msrpctypes\.unmarshall_winreg_String/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_ShareType/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_ShareType/
syn match   nseFunc /msrpctypes\.srvsvc_ShareType_tostr/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetShareCtr0/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_NetShareCtr0/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetShareCtr1/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetShareCtr2/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetShareCtr/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_NetShareCtr/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_NetShareInfo/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetSessCtr10/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_NetSessCtr10/
syn match   nseFunc /msrpctypes\.marshall_srvsvc_NetSessCtr/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_NetSessCtr/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_Statistics/
syn match   nseFunc /msrpctypes\.unmarshall_srvsvc_Statistics_ptr/
syn match   nseFunc /msrpctypes\.marshall_samr_ConnectAccessMask/
syn match   nseFunc /msrpctypes\.unmarshall_samr_ConnectAccessMask/
syn match   nseFunc /msrpctypes\.samr_ConnectAccessMask_tostr/
syn match   nseFunc /msrpctypes\.marshall_samr_DomainAccessMask/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomainAccessMask/
syn match   nseFunc /msrpctypes\.samr_DomainAccessMask_tostr/
syn match   nseFunc /msrpctypes\.marshall_samr_AcctFlags/
syn match   nseFunc /msrpctypes\.unmarshall_samr_AcctFlags/
syn match   nseFunc /msrpctypes\.samr_AcctFlags_tostr/
syn match   nseFunc /msrpctypes\.marshall_samr_PasswordProperties/
syn match   nseFunc /msrpctypes\.unmarshall_samr_PasswordProperties/
syn match   nseFunc /msrpctypes\.samr_PasswordProperties_tostr/
syn match   nseFunc /msrpctypes\.unmarshall_samr_SamArray/
syn match   nseFunc /msrpctypes\.unmarshall_samr_SamArray_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DispInfoGeneral/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DispInfo/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomInfo1/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomInfo8/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomInfo12/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomainInfo/
syn match   nseFunc /msrpctypes\.unmarshall_samr_DomainInfo_ptr/
syn match   nseFunc /msrpctypes\.unmarshall_samr_Ids/
syn match   nseFunc /msrpctypes\.marshall_svcctl_ControlCode/
syn match   nseFunc /msrpctypes\.unmarshall_svcctl_ControlCode/
syn match   nseFunc /msrpctypes\.svcctl_ControlCode_tostr/
syn match   nseFunc /msrpctypes\.marshall_svcctl_Type/
syn match   nseFunc /msrpctypes\.unmarshall_svcctl_Type/
syn match   nseFunc /msrpctypes\.svcctl_Type_tostr/
syn match   nseFunc /msrpctypes\.marshall_svcctl_State/
syn match   nseFunc /msrpctypes\.unmarshall_svcctl_State/
syn match   nseFunc /msrpctypes\.svcctl_State_tostr/
syn match   nseFunc /msrpctypes\.unmarshall_SERVICE_STATUS/
syn match   nseFunc /msrpctypes\.marshall_atsvc_DaysOfMonth/
syn match   nseFunc /msrpctypes\.marshall_atsvc_Flags/
syn match   nseFunc /msrpctypes\.marshall_atsvc_DaysOfWeek/
syn match   nseFunc /msrpctypes\.marshall_atsvc_JobInfo/
syn match   nseFunc /mysql\.receiveGreeting/
syn match   nseFunc /mysql\.loginRequest/
syn match   nseFunc /mysql\.decodeField/
syn match   nseFunc /mysql\.decodeQueryResponse/
syn match   nseFunc /mysql\.decodeFieldPackets/
syn match   nseFunc /mysql\.decodeResultSetHeader/
syn match   nseFunc /mysql\.decodeDataPackets/
syn match   nseFunc /mysql\.sqlQuery/
syn match   nseFunc /netbios\.name_encode/
syn match   nseFunc /netbios\.name_decode/
syn match   nseFunc /netbios\.get_names/
syn match   nseFunc /netbios\.get_server_name/
syn match   nseFunc /netbios\.get_user_name/
syn match   nseFunc /netbios\.do_nbstat/
syn match   nseFunc /netbios\.flags_to_string/
syn match   nseFunc /nsedebug\.tostr/
syn match   nseFunc /nsedebug\.print_hex/
syn match   nseFunc /nsedebug\.print_stack/
syn match   nseFunc /packet\.u8/
syn match   nseFunc /packet\.u16/
syn match   nseFunc /packet\.u32/
syn match   nseFunc /packet\.set_u8/
syn match   nseFunc /packet\.set_u16/
syn match   nseFunc /packet\.set_u32/
syn match   nseFunc /packet\.in_cksum/
syn match   nseFunc /packet\.Packet:new/
syn match   nseFunc /packet\.iptobin/
syn match   nseFunc /packet\.toip/
syn match   nseFunc /packet\.Packet:u8/
syn match   nseFunc /packet\.Packet:u16/
syn match   nseFunc /packet\.Packet:u32/
syn match   nseFunc /packet\.Packet:raw/
syn match   nseFunc /packet\.Packet:set_u8/
syn match   nseFunc /packet\.Packet:set_u16/
syn match   nseFunc /packet\.Packet:set_u32/
syn match   nseFunc /packet\.Packet:ip_parse/
syn match   nseFunc /packet\.Packet:ip_set_hl/
syn match   nseFunc /packet\.Packet:ip_set_len/
syn match   nseFunc /packet\.Packet:ip_set_ttl/
syn match   nseFunc /packet\.Packet:ip_set_checksum/
syn match   nseFunc /packet\.Packet:ip_count_checksum/
syn match   nseFunc /packet\.Packet:ip_set_bin_src/
syn match   nseFunc /packet\.Packet:ip_set_bin_dst/
syn match   nseFunc /packet\.Packet:ip_set_options/
syn match   nseFunc /packet\.Packet:ip_tostring/
syn match   nseFunc /packet\.Packet:parse_options/
syn match   nseFunc /packet\.Packet:tostring/
syn match   nseFunc /packet\.Packet:icmp_parse/
syn match   nseFunc /packet\.Packet:icmp_tostring/
syn match   nseFunc /packet\.Packet:tcp_parse/
syn match   nseFunc /packet\.Packet:tcp_tostring/
syn match   nseFunc /packet\.Packet:tcp_parse_options/
syn match   nseFunc /packet\.Packet:tcp_set_sport/
syn match   nseFunc /packet\.Packet:tcp_set_dport/
syn match   nseFunc /packet\.Packet:tcp_set_seq/
syn match   nseFunc /packet\.Packet:tcp_set_flags/
syn match   nseFunc /packet\.Packet:tcp_set_urp/
syn match   nseFunc /packet\.Packet:tcp_set_checksum/
syn match   nseFunc /packet\.Packet:tcp_count_checksum/
syn match   nseFunc /packet\.Packet:tcp_lookup_link/
syn match   nseFunc /packet\.Packet:udp_parse/
syn match   nseFunc /packet\.Packet:udp_tostring/
syn match   nseFunc /packet\.Packet:udp_set_sport/
syn match   nseFunc /packet\.Packet:udp_set_dport/
syn match   nseFunc /packet\.Packet:udp_set_length/
syn match   nseFunc /packet\.Packet:udp_set_checksum/
syn match   nseFunc /packet\.Packet:udp_count_checksum/
syn match   nseFunc /pgsql\.requestSSL/
syn match   nseFunc /pgsql\.createMD5LoginHash/
syn match   nseFunc /pgsql\.printErrorMessage/
syn match   nseFunc /pgsql\.detectVersion/
syn match   nseFunc /pop3\.stat/
syn match   nseFunc /pop3\.login_user/
syn match   nseFunc /pop3\.login_sasl_plain/
syn match   nseFunc /pop3\.login_sasl_login/
syn match   nseFunc /pop3\.login_apop/
syn match   nseFunc /pop3\.capabilities/
syn match   nseFunc /pop3\.login_sasl_crammd5/
syn match   nseFunc /proxy\.test_get/
syn match   nseFunc /proxy\.test_head/
syn match   nseFunc /proxy\.test_connect/
syn match   nseFunc /proxy\.hex_resolve/
syn match   nseFunc /proxy\.return_args/
syn match   nseFunc /proxy\.connectProxy/
syn match   nseFunc /proxy\.socksHandshake/
syn match   nseFunc /proxy\.redirectCheck/
syn match   nseFunc /smbauth\.next_account/
syn match   nseFunc /smbauth\.add_account/
syn match   nseFunc /smbauth\.get_account/
syn match   nseFunc /smbauth\.init_account/
syn match   nseFunc /smbauth\.ntlm_create_hash/
syn match   nseFunc /smbauth\.lm_create_response/
syn match   nseFunc /smbauth\.ntlm_create_response/
syn match   nseFunc /smbauth\.ntlm_create_mac_key/
syn match   nseFunc /smbauth\.lm_create_mac_key/
syn match   nseFunc /smbauth\.ntlmv2_create_hash/
syn match   nseFunc /smbauth\.lmv2_create_response/
syn match   nseFunc /smbauth\.ntlmv2_create_response/
syn match   nseFunc /smbauth\.get_password_response/
syn match   nseFunc /smbauth\.get_security_blob/
syn match   nseFunc /smbauth\.calculate_signature/
syn match   nseFunc /smb\.add_account/
syn match   nseFunc /smb\.get_account/
syn match   nseFunc /smb\.get_overrides/
syn match   nseFunc /smb\.get_overrides_anonymous/
syn match   nseFunc /smb\.get_status_name/
syn match   nseFunc /smb\.get_port/
syn match   nseFunc /smb\.disable_extended/
syn match   nseFunc /smb\.start/
syn match   nseFunc /smb\.start_ex/
syn match   nseFunc /smb\.stop/
syn match   nseFunc /smb\.start_raw/
syn match   nseFunc /smb\.start_netbios/
syn match   nseFunc /smb\.smb_send/
syn match   nseFunc /smb\.smb_read/
syn match   nseFunc /smb\.negotiate_protocol/
syn match   nseFunc /smb\.start_session/
syn match   nseFunc /smb\.tree_connect/
syn match   nseFunc /smb\.tree_disconnect/
syn match   nseFunc /smb\.logoff/
syn match   nseFunc /smb\.create_file/
syn match   nseFunc /smb\.read_file/
syn match   nseFunc /smb\.write_file/
syn match   nseFunc /smb\.close_file/
syn match   nseFunc /smb\.delete_file/
syn match   nseFunc /smb\.send_transaction_named_pipe/
syn match   nseFunc /smb\.send_transaction_waitnamedpipe/
syn match   nseFunc /smb\.file_write/
syn match   nseFunc /smb\.file_read/
syn match   nseFunc /smb\.files_exist/
syn match   nseFunc /smb\.file_delete/
syn match   nseFunc /smb\.share_anonymous_can_write/
syn match   nseFunc /smb\.share_user_can_write/
syn match   nseFunc /smb\.share_anonymous_can_read/
syn match   nseFunc /smb\.share_user_can_read/
syn match   nseFunc /smb\.share_host_returns_proper_error/
syn match   nseFunc /smb\.share_get_details/
syn match   nseFunc /smb\.share_get_list/
syn match   nseFunc /smb\.share_find_writable/
syn match   nseFunc /smb\.get_windows_version/
syn match   nseFunc /smb\.get_os/
syn match   nseFunc /smb\.get_socket_info/
syn match   nseFunc /smb\.get_uniqueish_name/
syn match   nseFunc /smb\.is_admin/
syn match   nseFunc /snmp\.encode/
syn match   nseFunc /snmp\.decode/
syn match   nseFunc /snmp\.dec/
syn match   nseFunc /snmp\.buildPacket/
syn match   nseFunc /snmp\.buildGetRequest/
syn match   nseFunc /snmp\.buildGetNextRequest/
syn match   nseFunc /snmp\.buildSetRequest/
syn match   nseFunc /snmp\.buildTrap/
syn match   nseFunc /snmp\.buildGetResponse/
syn match   nseFunc /snmp\.str2oid/
syn match   nseFunc /snmp\.oid2str/
syn match   nseFunc /snmp\.ip2str/
syn match   nseFunc /snmp\.str2ip/
syn match   nseFunc /snmp\.fetchResponseValues/
syn match   nseFunc /snmp\.fetchFirst/
syn match   nseFunc /snmp\.snmpWalk/
syn match   nseFunc /stdnse\.strjoin/
syn match   nseFunc /stdnse\.strsplit/
syn match   nseFunc /stdnse\.make_buffer/
syn match   nseFunc /stdnse\.lines/
syn match   nseFunc /stdnse\.tooctal/
syn match   nseFunc /stdnse\.tohex/
syn match   nseFunc /stdnse\.string_or_blank/
syn match   nseFunc /stdnse\.parse_timespec/
syn match   nseFunc /stdnse\.format_difftime/
syn match   nseFunc /stdnse\.clock_ms/
syn match   nseFunc /stdnse\.clock_us/
syn match   nseFunc /stdnse\.format_output/
syn match   nseFunc /stdnse\.get_script_args/
syn match   nseFunc /strbuf\.concatbuf/
syn match   nseFunc /strbuf\.eqbuf/
syn match   nseFunc /strbuf\.clear/
syn match   nseFunc /strbuf\.tostring/
syn match   nseFunc /strbuf\.new/
syn match   nseFunc /strict\.strict/
syn match   nseFunc /strict\.module/
syn match   nseFunc /tab\.new/
syn match   nseFunc /tab\.add/
syn match   nseFunc /tab\.addrow/
syn match   nseFunc /tab\.nextrow/
syn match   nseFunc /tab\.dump/
syn match   nseFunc /url\.escape/
syn match   nseFunc /url\.unescape/
syn match   nseFunc /url\.parse/
syn match   nseFunc /url\.build/
syn match   nseFunc /url\.absolute/
syn match   nseFunc /url\.parse_path/
syn match   nseFunc /url\.build_path/
syn match   nseFunc /url\.parse_query/
syn match   nseFunc /url\.build_query/


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_nse_syntax_inits")
  if version < 508
    let did_nse_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink nseStatement		Statement
  HiLink nseRepeat		Repeat
  HiLink nseString		String
  HiLink nseString2		String
  HiLink nseNumber		Number
  HiLink nseFloat		Float
  HiLink nseOperator		Operator
  HiLink nseConstant		Constant
  HiLink nseCond		Conditional
  HiLink nseFunction		Function
  HiLink nseComment		Comment
  HiLink nseTodo		Todo
  HiLink nseTable		Structure
  HiLink nseError		Error
  HiLink nseSpecial		SpecialChar
  HiLink nseFunc		Identifier

  delcommand HiLink
endif

let b:current_syntax = "nse"

" vim: et ts=8
