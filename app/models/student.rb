class Student < ActiveRecord::Base
    require 'csv'
    def self.to_csv(all_products, selected_columns)
        
        puts "========================"
        puts selected_columns.inspect
        puts "========================"
        
        hasCount = selected_columns.find { |item| item =~ /count/i }
        selected_columns.reject!{|item| item =~ /count/i }
        
        CSV.generate do |csv|
            if hasCount
               csv << ["Count = " + all_products.length.to_s]
            end
            csv << selected_columns
            all_products.each do |product|
                csv << product.attributes.values_at(*selected_columns)
            end
        end
    end
    
   
    
    def self.csv_table(product,c_filter,r_filter,c_attri,r_attri)
        CSV.generate do |csv|
         #   raise params.inspect
            csv<<c_attri
            i=0
            r_filter.each do |r|
                temp=[]
                temp<<r_attri[i]
              
                i=i+1
                c_filter.each do |c|    
            
                    temp<<product.where(c).where(r).count.to_s
                    
                    
                end
                csv<<temp
            end
        end    
        
    end
    
    def self.altercsv (array)
    CSV.generate do |csv|
    array.each do |t|
        csv<<t
    
    end
    end
    end
    
end
