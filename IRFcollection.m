classdef IRFcollection < IRF
    %IRFCOLLECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function  obj = IRFcollection(IRFmatrix,names,label)
            if nargin ~= 0
                nElements = size(IRFmatrix,1);
                obj(nElements) = IRFcollection;
                for i = 1:nElements
                    currentIRF = IRF(IRFmatrix(i,:),names(i),label);
                    obj(i).Values = currentIRF.Values;
                    obj(i).labelTS = names(i);
                    obj(i).label = label;
                end
            end
        end
        function  obj = setValues(obj,values)
            nElements = size(obj,2);
            for i = 1 : nElements
                obj(i).Values=values(i,:);
            end
        end
        function  obj = setLabel(obj, label)
            nElements = size(obj,2);
            for i = 1 : nElements
                obj(i).label=label;
            end
        end
        function obj = setUnits(obj,unitsOfMeasurement)
            [nLines, nPlots] = size(obj);
            for j = 1:nPlots
                for i = 1 : nLines
                    obj(i,j).unitsOfMeasurement = unitsOfMeasurement;
                end
            end
        end
        function obj = setMarker(obj,markerStr)
            [nLines, nPlots] = size(obj);
            for j = 1:nPlots
                for i = 1 : nLines
                    obj(i,j).markerString=markerStr;
                end
            end
        end
        function  irfMat =  matrixForm(obj)
            nElements = size(obj,2);
            maxHorizon = size(obj(1).Values,2);
            irfMat = zeros(nElements,maxHorizon);
            for i = 1 : nElements
                irfMat(i,:) = obj(i).Values;
            end
        end
        function  d = double(obj)
            d = obj.matrixForm;
        end
        
        function figureArray = plotPanel(obj,printFilePath)
            [nLines, nPlots] = size(obj);
            for j = 1:nPlots
               figureArray(j) = figure;
                for i = 1 : nLines
                    plot(obj(i,j));
                    hold on;
                end
                if nargin>1
                     fn_print(figureArray(j),[printFilePath filesep obj(i,j).getLabelTS]);
                end
            
            end
        end
    end
    
end



function fn_print(h,name)

set(h, 'PaperUnits','centimeters');
set(h, 'Units','centimeters');
pos=get(h,'Position');
set(h, 'PaperSize', [pos(3) pos(4)]);
set(h, 'PaperPositionMode', 'manual');
set(h, 'PaperPosition',[0 0 pos(3) pos(4)]);
 
print(name,'-dpdf')
print(name,'-depsc2')
 

end