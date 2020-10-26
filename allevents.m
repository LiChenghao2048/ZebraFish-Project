function allevents(src,evt)
evname = evt.EventName;
    switch(evname)
        case{'MovingROI'}
            disp(['ROI moving Current Center: ' mat2str(evt.CurrentCenter)]);
            disp(['ROI moving Current Radius: ' mat2str(evt.CurrentRadius)]);
        case{'ROIMoved'}
            disp(['ROI moved Current Center: ' mat2str(evt.CurrentCenter)]);
            disp(['ROI moved Current Radius: ' mat2str(evt.CurrentRadius)]);
    end
end