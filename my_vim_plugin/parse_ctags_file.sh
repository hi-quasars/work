#!/bin/bash

function parse_ctag()
{
    ctag=$1
    awk -F'\t' '                    \
        BEGIN       {               \
                        stypestr="#Macro_#Enum_#Struct_#Union_#Typedef_#Variable_#Function";  \
                        stagtypestr="d_g_s_u_t_v_f";                \
                        typenum=split(stypestr, typestr, "_");      \
                        split(stagtypestr, tagtypestr, "_");        \
                        for(i = 1; i <= typenum; i++){  \
                            tags[typestr[i]] = "";      \
                            tagsindex[tagtypestr[i]] = typestr[i];   \
                        }   \
                    } \
        /^[^\!]+/   {                       \
                        tag_name = $1;      \
						tag_cmd  = $3;		\
                        tag_type = $4;      \
						tag_nc = tag_name "" "\n" "" tag_cmd; \
                        if( tags[tagsindex[tag_type]] == "" ){      \
                            tags[tagsindex[tag_type]] = tag_nc;   \
                        }else{  \
                            tags[tagsindex[tag_type]] = tags[tagsindex[tag_type]] "" "\n" ""  tag_nc;  \
                        }   \
                    }  \
        END         {  \
                        result = "";    \
                        for(i = 1; i < typenum; i++){      \
							if( tags[typestr[i]] == "" ){	\
								result = result "" typestr[i] "" "\n"; \
							}else{	\
                            	result = result "" typestr[i] "" "\n" "" tags[typestr[i]] "" "\n";    \
                        	}	\
						}   \
						result = result "" typestr[i] "" "\n" "" tags[typestr[i]];	\
                        print result;    \
                    }  \
    ' $ctag
}


parse_ctag $1
