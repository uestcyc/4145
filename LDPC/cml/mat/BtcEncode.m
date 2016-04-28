function codeword = BtcEncode( data, grows, gcolumns, k_per_row, k_per_column, B, Q )
% BTCEncode encodes a data sequence using a block turbo encoder.  
%
% The calling syntax is:
%     codeword = BtcEncode( data, grows, gcolumns, k_per_row, k_per_column, B, Q )
%
%     codeword = the codeword generated by the encoder,
%
%     data = the row vector of data bits
%     grows = the generator used to encode the rows
%     gcolumns = the generator used to encode the columns
%     k_per_row = number of data bits per row
%     k_per_column = number of data bits per column
%     B = number of zeros padded before data but not transmitted
%     Q = number of zeros padded before data and transmitted
%
% Copyright (C) 2008, Matthew C. Valenti and Sushma Mamidipaka
%
% Last updated on May 22, 2008
%
% Function BtcEncode is part of the Iterative Solutions Coded Modulation
% Library (ISCML).  
%
% The Iterative Solutions Coded Modulation Library is free software;
% you can redistribute it and/or modify it under the terms of 
% the GNU Lesser General Public License as published by the 
% Free Software Foundation; either version 2.1 of the License, 
% or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

% create a matrix of data bits padded with B+Q zeros at the beginning
padded_data = [zeros( 1, B+Q ) data];

% turn data into rectangular matrix
data_matrix = reshape( padded_data, k_per_row, k_per_column )';

% Encode each row
for i=1:k_per_column
    encoded_rows(i,:) = ConvEncode( data_matrix(i,:), grows, 0);
end

% Encode each column
for i=1:size( encoded_rows, 2 )
    encoded_columns(:,i)=ConvEncode( encoded_rows(:,i)', gcolumns, 0)';
end

% Turn into a row vector
codeword = reshape( encoded_columns', 1, prod( size( encoded_columns ) ) );

% Strip out first B bits of codeword
codeword = codeword( B+1:length(codeword) );
