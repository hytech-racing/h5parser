function S=setfld(S,fieldpath,V)
%A somewhat enhanced version of setfield() allowing one to set
%fields in substructures of structure/object S by specifying the FIELDPATH.
%
%Usage:  setfld(S,'s.f',V) will set S.s.f=V  
%                                            
%
%%Note that for structure S, setfield(S.s,'f') would crash with an error if 
%S.s did not already exist. Moreover, it would return a modified copy
%of S.s rather than a modified copy of S, behavior which would often be 
%undesirable.
%
%
%Works for any object capable of a.b.c.d ... subscripting
%
%Currently, only single structure input is supported, not structure arrays.


try
 eval(['S.' fieldpath '=V;']);
catch
 error 'Something''s wrong.';
end