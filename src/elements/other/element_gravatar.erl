-module (element_gravatar).
-compile(export_all).
-include("wf.inc").

reflect() -> record_info(fields, gravatar).

render(ControlID, Record) -> 
    Image = #image {
        image = gravatar_icon(Record)
    },
    element_image:render(ControlID, Image).

gravatar_icon(#gravatar{email=Email, size=Size, rating=Rating, default=Default}) ->
    GravatarId = lists:flatten([io_lib:format("~2.16.0b",[N]) || N <- binary_to_list(erlang:md5(wf:clean_lower(Email)))]),
    wf:f("http://www.gravatar.com/avatar/~s?size=~s&r=~s&d=~s" ,
         [GravatarId, Size, Rating, Default]).
