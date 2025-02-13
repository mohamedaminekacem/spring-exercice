<div class="search-container">
    <form action="search.html" method="GET" class="search-form">
        <input type="text" name="first_name" placeholder="First Name" value="${first_name}" />
        <input type="text" name="last_name" placeholder="Last Name" value="${last_name}" />
        <select name="gender">
            <option value="">Select Gender</option>
            <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
            <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
        </select>
        <button type="submit" class="search-button">
            <i class="bi bi-search"></i> <!-- FontAwesome Icon -->
        </button>
    </form>
</div>

<style>
    .search-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
    }

    .search-form {
        display: flex;
        width: 600px;
        background: #f5f5f5;
        border: 1px solid #ccc;
    }

    .search-form input,
    .search-form select {
        flex: 1;
        border: none;
        padding: 12px 15px;
        font-size: 14px;
        background: transparent;
        outline: none;
    }

    .search-form select {
        cursor: pointer;
    }

    .search-button {
        background: #1e3a8a; /* Dark Blue */
        border: none;
        padding: 12px 20px;
        cursor: pointer;
        transition: background 0.3s;
        color: white;
        font-size: 16px;
    }

    .search-button:hover {
        background: #0f235c;
    }
</style>
