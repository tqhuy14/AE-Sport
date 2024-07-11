/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBContext;

import Model.UserAccount;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *

 */
public class AccountDAO extends DBContext{
  
    public boolean UpdateProfile(UserAccount user) {    
        String sql = "UPDATE UserAccounts SET full_name = ?, email = ?, phone_number = ?, address = ? where user_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getFull_Name());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPhone_number());
           st.setString(4, user.getAddress());
            st.setInt(5, user.getUse_ID());
                return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }
    
    public UserAccount CheckLogin(String userName,String password) {
        String sql = "SELECT * FROM [dbo].[UserAccounts] where username = ? AND password_hash = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserAccount user = new UserAccount(rs.getInt("user_ID"),
                       rs.getString("address"),
                        rs.getString("password_hash"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number")
                );
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }


    
    public int insertUserAccount(UserAccount u) {
        int newId = 0;
        try {
            String sql = "insert into [UserAccounts]([address],[password_hash],[username],[full_name],[email],[phone_number],[status]) values(?,?,?,?,?,?,'active')";
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
           st.setString(1, u.getAddress());
            st.setString(2, u.getPassword());
            st.setString(3, u.getUserName());
            st.setString(4, u.getFull_Name());
            st.setString(5, u.getEmail());
            st.setString(6, u.getPhone_number());
            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        newId = (int)generatedKeys.getLong(1);
                    } else {
                        throw new SQLException("Creating account failed, no ID obtained.");
                    }
                }
            }
            return  newId;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public boolean validateUserName(String userName) {
        String sql = "SELECT * FROM [dbo].[UserAccounts] where username = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public void updateUserAccount(String newpass, int userId) {
        try {
            String sql = " UPDATE [UserAccounts] SET [password_hash] = ? WHERE [user_ID] = ?";
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, newpass);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public int GetAccountByEmail(String email){
        String sql = "SELECT * FROM [dbo].[UserAccounts] where email = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("user_ID");
            }
            return 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    public String getAddress(int userId) {
    String address = null;
    String sql = "SELECT [address] FROM [dbo].[UserAddresses] WHERE [user_ID] = ?";
    try {
           PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            address = rs.getString("address");
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return address;
}

    
    public void change(String password, String userName) {
    String sql = "UPDATE [dbo].[UserAccounts] SET [password_hash] = ? WHERE [username]=?";
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, password);
        st.setString(2, userName);
        st.executeUpdate(); // Use executeUpdate() for update operations
    } catch (SQLException e) {
        System.out.println(e);
    }
}
      // Phương thức để lấy báo cáo đăng ký người dùng
    public Map<String, Integer> getUserRegistrationReport(String period) {
        String sql = "SELECT dateCreate, COUNT(*) as registration_count FROM UserAccounts WHERE dateCreate >= DATEADD(DAY, -?, GETDATE()) GROUP BY dateCreate";
        Map<String, Integer> report = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, period.equals("day") ? 1 : (period.equals("week") ? 7 : 30));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    report.put(rs.getString("dateCreate"), rs.getInt("registration_count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return report;
    }

    // Phương thức để lấy báo cáo hoạt động người dùng
      public Map<String, Integer> getUserActivityReport(String period) {
        String sql = "";
        if ("day".equals(period)) {
            sql = "SELECT dateCreate, COUNT(*) as activity_count FROM UserAccounts WHERE status = 'active' AND dateCreate >= DATEADD(DAY, -1, GETDATE()) GROUP BY dateCreate";
        } else if ("week".equals(period)) {
            sql = "SELECT dateCreate, COUNT(*) as activity_count FROM UserAccounts WHERE status = 'active' AND dateCreate >= DATEADD(DAY, -7, GETDATE()) GROUP BY dateCreate";
        } else if ("month".equals(period)) {
            sql = "SELECT dateCreate, COUNT(*) as activity_count FROM UserAccounts WHERE status = 'active' AND dateCreate >= DATEADD(DAY, -30, GETDATE()) GROUP BY dateCreate";
        }

        Map<String, Integer> report = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    report.put(rs.getString("dateCreate"), rs.getInt("activity_count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return report;
    }

    // Phương thức để lấy báo cáo hoạt động người dùng tùy chỉnh
    public Map<String, Integer> getCustomUserActivityReport(String startDate, String endDate) {
        String sql = "SELECT dateCreate, COUNT(*) as registration_count FROM UserAccounts WHERE dateCreate BETWEEN ? AND ? GROUP BY dateCreate";
        Map<String, Integer> report = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    report.put(rs.getString("dateCreate"), rs.getInt("registration_count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return report;
    }
    
    
}
