%% convert from english to metric units     
    function converted = convert2metric_inches(metricParameter)
        converted = metricParameter * 25.4;
    end

    function converted = convert2metric_pounds(metricParameter)
        converted = metricParameter * 4.44822;
    end