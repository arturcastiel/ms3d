function varargout = convert_to_sparse(varargin)
    for k = 1:nargout
        varargout{k} = sparse(varargin{k});
    end
end